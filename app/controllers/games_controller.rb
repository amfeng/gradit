class GamesController < ApplicationController
  
  require "lib/avro_record.rb"
  # GET /games
  # GET /games.xml
  def index
    #Note: .all does not yet work
    #@games = Game.all

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
    #Find currentword in the game and answer chosen  
    choice = params[:answer]
    answer = Word.find(params[:id].to_i)

    puts "@@@@AND THE ANSWER IS@@@@@@@@"
    if choice == answer.word #If correct answer
      puts "CORRECT"
      #Pick a new "current" word from the wordlist **NEED TO OPTIMIZE THIS**
      wordlist = WordList.find(params[:wordlist])
      
      if !Word.find(2)
        w2 = Word.createNew(2, "chastise", "definition", "wordlist")
        wc2 = WordContext.createNew(2, "Book Title 2", 9, "This is what the chastise book line is lol.")
      
        w3 = Word.createNew(3, "amber", "definition", "wordlist")
        wc3 = WordContext.createNew(1, "Book Title 3", 8, "This is what the book amber line is vex lol.")
      
        w4 = Word.createNew(4, "rawr", "definition", "wordlist")
        wc4 = WordContext.createNew(4, "Book Title 4", 7, "This is what the book line is lol rawr.")
      end
      #words = wordlist.words 
      words = [Word.find(2), Word.find(3), Word.find(4)] #FIXME: replace with actual query wordlist.words
      
      #Pick a random word next
      nextWord = words[rand(words.length())]
      
      #Raise score
      score = 0 #FIXME
      
      flash[:notice] = "Correct!"
      redirect_to(:controller=> :games, :action=> :game_entry, :id => nextWord.wordid)
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
      score = 0 
     
      flash[:notice] = "Oops, that's wrong"
      redirect_to(:controller=> :games, :action=> :game_entry, :id => params[:id])
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
    w = Word.createNew(1, "vex", "definition", "wordlist")
    wc = WordContext.createNew(1, "Book Title", 5, "This is what the book line is vex lol.")
    
  	currentword = Word.find(params[:id].to_i)
    word = currentword.word
    
    puts "***"
    puts word
    
    #Get a random context for the word
    @para = false
    contexts = currentword.contexts #get context
    con = contexts.sort_by{ rand }.first

  	if(con)
  	  #Initialize paragraph, multiple choice settings
  	  @para_book = con.book;
      @para = con.wordLine
      @para.gsub!(word, '___________') #underline the missing word    
      @mc = currentword.choices  
      @mc_array = (@mc << word).sort_by{ rand }
    else #Find another word to use, no contexts
      wordlist = WordList.find(params[:wordlist])
      #words = wordlist.words
      words = [Word.find(2), Word.find(3), Word.find(4)]
      currentword = words[rand(words.length)].word
      
      redirect_to(:controller=> :games, :action=> :game_entry)
    end    
    nexturl = url_for :controller => :games, :action => :game_entry
    @disp = nexturl
  end

  def new_game
    wordlist = WordList.findWordlist(params[:wordlist])
    words = wordlist.words
    currentword = words[rand(words.length)]
    
    if(currentword) #If there is a word
      #Save the currentword in the session or something?
      redirect_to(:controller=> :games, :action=> :game_entry)
      return
    end
    flash[:notice] = "Wordlist has no words!"
    redirect_to :back
  end
end
