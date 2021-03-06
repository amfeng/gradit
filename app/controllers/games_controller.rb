class GamesController < ApplicationController
  
  # GET /games
  # GET /games.xml
  def index
    #Note: .all does not yet work
    @games = Game.all
    @wordlists = WordList.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
 
  #Check if the answer was correct
  def ans
    puts "Inside ANS"
    game = Game.find(params[:id].to_i)
    #Find currentword in the game and answer chosen  
    choice = params[:answer]
    answer = game.currentword

    puts "@@@@AND THE ANSWER IS@@@@@@@@"
    if choice == answer #If correct answer
      puts "CORRECT"
      #Pick a new "current" word from the wordlist **NEED TO OPTIMIZE THIS**
      wordlist = game.wordlist

      #words = wordlist.words 
      words = [Word.find(2), Word.find(3), Word.find(4)] #FIXME: replace with actual query wordlist.words
      
      #Pick a random word next
      nextWord = words[rand(words.length())]
      game.changeWord(nextWord.word)
      
      #Raise score
      game.incrementScore(10)
      
      flash[:notice] = "Correct!"
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.gameid)
      #AJAX update page to reflect changes in score, let the user know they are correct
      #render :update do |page|
    	#  page[:ans_result].replace_html "Correct! Press next." #**NEED TO HAVE THIS REDIRECT, BUT IT DOESN'T WORK**
     	#  page[:player_score].replace_html "#{score}"
     	#  page[:player_score].highlight
     	#
      #  page["mult_choice_#{choice}"].replace_html "<b>#{choice} (definition: #{answer.definition})</b>"
      #end
      
    else #Incorrect answer
      puts "INCORRECT"
      
      #Lower score 
      game.incrementScore(-5)
     
      flash[:notice] = "Oops, that's wrong"
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.gameid)
      #AJAX update page to reflect changes in score, let user know they are incorrect
      #render :update do |page|
      #  page[:ans_result].replace_html "Wrong, try again!"
	    #  page[:player_score].replace_html "#{score}"
      #  page[:player_score].highlight
      #  page["mult_choice_#{choice}"].replace_html "#{choice} (definition: #{answer.definition})"
      #end
    end
  end
  
  #Displaying/picking questions
  def game_entry
    game = Game.find(params[:id].to_i)
  	word = game.currentword
  	#w = Word.find_by_word(word)
    w = Word.find(1) #HACK: fix me
  	
  	@score = game.score
  
    puts "***"
    puts word
    
    #Get a random context for the word
    @para = false
    contexts = w.contexts #get context
    con = contexts.sort_by{ rand }.first

  	if(con)
  	  #Initialize paragraph, multiple choice settings
  	  @para_book = con.book;
      @para = con.wordLine
      @para.gsub!(word, '___________') #underline the missing word    
      @mc = w.choices 
      @mc_array = (@mc << word).sort_by{ rand }
    else #Find another word to use, no contexts
      wordlist = WordList.find(params[:wordlist])
      #words = wordlist.words
      words = [Word.find(2), Word.find(3), Word.find(4)]
      currentword = words[rand(words.length)].word
      
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.gameid)
    end    
    nexturl = url_for :controller => :games, :action => :game_entry, :id => game.gameid
    @disp = nexturl
  end

  def new_game
    wordlist = WordList.find(params[:wordlist])
    game = Game.createNew(wordlist.name)
    
    #words = wordlist.words 
    #currentword = words[rand(words.length)]
    currentword = Word.find(1) #FIXME: to above
    game.changeWord(currentword.word)

    
    if(currentword) #If there is a word
      #Save the currentword in the session or something?
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.gameid)
      return
    end
    flash[:notice] = "Wordlist has no words!"
    redirect_to :back
  end
end
