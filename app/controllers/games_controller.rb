class GamesController < ApplicationController
	
  before_filter :login_required
  before_filter :active_filter, :only => [:new_game]
  # GET /games
  # GET /games.xml
  def index
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

  def ans
  	user_id = curr_user_id
  	game = Game.find(params[:id])
  	
  	@player = GamePlayer.find(:first, :conditions => {:game_id => game.id, :user_id => user_id})
  	
    
    if game.answer_choice(params[:answer])
      wordlist = game.wordlist.words
      game.currentword = wordlist[rand(wordlist.length)].word
      game.save
      @player.score += 10
      @player.save
      #render :text => "You are correct!"
      #redirect_to(:controller => :games, :action => :game_entry, :id => game.id, :right => true)
      render :update do |page|
    	page[:ans_result].replace_html "Correct! Press next."
     	page[:player_score].replace_html "#{@player.score}"
     	page[:player_score].highlight
  	  end
      
    else
    	@player.score -= 5
    	@player.save
    	#render :text => "You fail."
    	render :update do |page|
	    	page[:ans_result].replace_html "Wrong, try again!"
	    	page[:player_score].replace_html "#{@player.score}"
	    	page[:player_score].highlight
  	    end
    end
  end
  

  def game_entry
  	user_id = curr_user_id
  	
  	game = Game.find(params[:id])
  	word = Word.find_by_word(game.currentword)
  	
  	@player = GamePlayer.find(:first, :conditions => {:game_id => game.id, :user_id => user_id})
    @game_id = game.id
    definition = word.definition
    puts definition
    @para = false
    contexts = Search.search(word.word) #get context
  	con = contexts[rand(contexts.length)]
  	if(con)
  	  @para_book = con[3];
      @para = con[0] << con[1] << con[2]
      @para.gsub!(word.word, '___________') #underline the missing word
      @mc = word.choices
      @mc_array = @mc.getChoices
    else
      wordlist = game.wordlist.words
      game.currentword = wordlist[rand(wordlist.length)].word
      game.save
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.id)
    end    
    nexturl = url_for :controller => :games, :action => :game_entry, :id => game.id
    @disp = nexturl
  end

  def new_game
    user_id = curr_user_id
  	
  	game = Game.new(:wordlist_id => params[:id], :finished => false, :winner_id => nil)
  	game.save
  	
  	player = GamePlayer.new(:game_id => game.id, :user_id => user_id, :score => 0)
  	player.save
  	word = game.wordlist.words
    word = word[rand(word.length)]
  	if(word)
      game.currentword = word.word
      game.save
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.id)
      return
  	end
  	flash[:notice] = "Wordlist has no words!"
  	redirect_to :back
  end
  
  def active_filter
  	active = current_user.has_active_game
  	if active
  		flash[:notice] = "Oops! You already have an active game. Please quit the current game before you try to open a new one!"
  		redirect_to :back
  	end
  	return true
  end
  
  def quit_game
  	game = Game.find(params[:game_id])
  	game.finished = true
  	game.save
  	redirect_to :controller => :dashboard
  end
  
  def vote_mc
 	vote = params[:vote] #true for up, false for down
 	mc = MultipleChoice.find(params[:mc_id])
  	puts vote
  	mc.score = mc.score + 1 if vote == "up"
  	mc.score = mc.score - 1 if vote == "down"
  	mc.save
  	
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
