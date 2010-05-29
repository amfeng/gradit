class GamesController < ApplicationController
	
  before_filter :guest_filter
  before_filter :active_filter, :only => [:new_game]
  # GET /games
  # GET /games.xml
  def index
    #Note: .all does not yet work
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  #Check if the answer was correct
  def ans
    #Find the current user, game, and word
    user_id = curr_user_id
    game = Query.gameById(params[:id])
    word = Query.wordByWord(game.currentword)
    
    @player = Query.game(game.id, user_id)
    choice = params[:answer]
    word = Query.wordByWord(choice)
    definition = word.definition

    #If correct answer
    if game.answer_choice(choice)
      #Pick a new "current" word **NEED TO OPTIMIZE THIS**
      wordlist = game.wordlist.words.to_a
      game.put("currentword", wordlist[rand(wordlist.length)].word)
      game.save
      
      #Add points to the user's score
      @player.score += 10
      @player.save
      
      #AJAX update page to reflect changes in score, let the user know they are correct
      render :update do |page|
    	page[:ans_result].replace_html "Correct! Press next." #**NEED TO HAVE THIS REDIRECT, BUT IT DOESN'T WORK**
     	page[:player_score].replace_html "#{@player.score}"
     	page[:player_score].highlight
     	
        page["mult_choice_#{choice}"].replace_html "<b>#{choice} - #{definition}</b>"
      end
      
    else #Incorrect answer
      #Lower score 
      @player.score -= 5
      @player.save
      
     
      #Add wrong choice to the database for making questions "smarter"
      #How do associations work in rails? Which fields do we set?
      #NEED TO CHANGE THE FOLLOWING LINE
      word.wrong_choices << WrongChoice.create(:wrong_choice_id => word.id)
      
      #Add defintion to incorrectly chosen word
      
      #AJAX update page to reflect changes in score, let user know they are incorrect
      render :update do |page|
        page[:ans_result].replace_html "Wrong, try again!"
	    page[:player_score].replace_html "#{@player.score}"
        page[:player_score].highlight
        page["mult_choice_#{choice}"].replace_html "#{choice} - #{definition}"
      end
    end
  end
  
  #Displaying/picking questions
  def game_entry
    user_id = curr_user_id
    
    game = Query.gameById(params[:id])
    word = Query.wordByWord(game.currentword)
    
    @player = Query.gamePlayerByGame(:game_id => game.id, :user_id => user_id)
    @game_id = game.id
    
    definition = word.definition
    
    #Get a random context for the word
    @para = false
    contexts = Search.search(word.word) #get context
  	con = contexts[rand(contexts.length)]
  	if(con)
  	  #Initialize paragraph, multiple choice settings
  	  @para_book = con.book.name;
      @para = con.before << con.wordline << con.after
      @para.gsub!(word.word, '___________') #underline the missing word
      @mc = word.choices
      @mc_array = @mc.getChoices
    else
      #Find another word to use, no contexts
      wordlist = Query.allWordList
      game.currentword = wordlist[rand(wordlist.length)].word
      game.save
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.id)
    end    
    nexturl = url_for :controller => :games, :action => :game_entry, :id => game.id
    @disp = nexturl
  end

  def new_game
    user_id = curr_user_id
    
    #Create the actual game object
    
    game = Game.new
    game.puts("wordlist_id", params[:id])
    game.puts("finished", false)
    game.puts("winner_id", nil)
    game.save
    
    #Create Game Player for the user
    player = GamePlayer.new
    player.puts("game_id", game.id)
    player.puts("user_id", user_id)
    player.puts("score", 0)
    player.save
  	
    #Select a random word from the wordlist for the new "current" word
    word = game.wordlist.words.to_a
    word = word[rand(word.length)]
    
    #If there is a word
    if(word)
      game.puts("currentword", word.word)
      game.save
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.id)
      return
    end
    flash[:notice] = "Wordlist has no words!"
    redirect_to :back
  end
  
  def active_filter
    #Is the user currently in an active (not-over) game?
    active = current_user.has_active_game
    if active
      flash[:notice] = "Oops! You already have an active game. Please quit the current game before you try to open a new one!"
      redirect_to :back
    end
    return true
  end
  
  def guest_filter
    #Allow guest access for playing games without login
    if User.guest_account_enabled
      if !authorized?
        self.current_user = User.find_by_login("guest")
        new_cookie_flag = (params[:remember_me] == "1")
        handle_remember_cookie! new_cookie_flag
      end
      return true
    else
      return false
    end
  end
  
  def quit_game
    #Quit the game - end the game and return to dashboard
    game = Query.gameById(params[:game_id])
    game.puts("finished", true)
    game.save
    redirect_to :controller => :dashboard
  end
  
  def vote_mc
    #Up/down voting multiple choices
    vote = params[:vote] #true for up, false for down
    mc = Query.multipleChoiceById(params[:mc_id])
    
    #Change multiple choice score accordingly
    mc.score = mc.score + 1 if vote == "up"
    mc.score = mc.score - 1 if vote == "down"
    mc.save
    
    #AJAX update the page to reflect changes
    render :update do |page|
      page[:mc_voting].replace_html "Your rating for this multiple choice question has been recorded."
      page[:mc_rating].replace_html "#{mc.score}"
      page[:mc_rating].highlight
    end
    
  end
  
  def next_word
  end
  
  def game_page
  end
  
  def curr_user_id
    user_id = 0
    user_id = current_user.id if(current_user)
    
    return user_id
  end
end
