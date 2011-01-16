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
    #Find currentword in the game and answer chosen  
    choice = Word.findWord(params[:answer].to_i).first.first
    word = choice.word
    definition = word.definition

	currentword = params[:currentword]

    if currentword == word #If correct answer
      #Pick a new "current" word from the wordlist **NEED TO OPTIMIZE THIS**
      wordlist = WordList.findWordlist(params[:wordlist]).first.first
      words = wordlist.words #FIXME: with real query
      
      #Raise score
      score = 0 #FIXME
      
      #AJAX update page to reflect changes in score, let the user know they are correct
      render :update do |page|
    	  page[:ans_result].replace_html "Correct! Press next." #**NEED TO HAVE THIS REDIRECT, BUT IT DOESN'T WORK**
     	  page[:player_score].replace_html "#{score}"
     	  page[:player_score].highlight
     	
        page["mult_choice_#{word}"].replace_html "<b>#{word} (definition: #{definition})</b>"
      end
      
    else #Incorrect answer
      #Lower score 
      score = 0 
     
      #AJAX update page to reflect changes in score, let user know they are incorrect
      render :update do |page|
        page[:ans_result].replace_html "Wrong, try again!"
	      page[:player_score].replace_html "#{score}"
        page[:player_score].highlight
        page["mult_choice_#{word}"].replace_html "#{word} (definition: #{definition})"
      end
    end
  end
  
  #Displaying/picking questions
  def game_entry
    w = Word.new
    w.wordid = 1
    w.word = "vex"
    w.definition = "definition"
    w.wordlist = "wordlist"
    w.save
    w.save #HACK: call everything twice for piql bug
    
    wc = WordContext.new
    wc.word = 1
    wc.book = "Book Title"
    wc.linenum = 5
    wc.wordLine = "This is what the book line is vex lol."
    wc.save
    wc.save #HACK: call everything twice for piql bug
    
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
      wordlist = WordList.findWordlist(params[:wordlist])
      words = wordlist.words
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
