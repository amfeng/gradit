class GamesController < ApplicationController
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
    game = Game.find(params[:id])
    if game.answer_choice(params[:answer])
      wordlist = game.wordlist.words
      game.currentword = wordlist[rand(wordlist.length)].word
      game.save
      #redirect_to(:controller=> :games, :action=> :game_entry, :id => game.id)
      render :update do |page|
        page.replace_html 'ans', "You are correct!" 
      end
    else
      render :update do |page|
        page.replace_html 'ans', "You fail." 
      end
    end
  end

  def game_entry
    game = Game.find(params[:id])
  	word = game.currentword
    definition = Word.find_by_word(word).definition
    puts definition
    @disp = ''
    @para = false
    contexts = Search.search(word) #get context
  	con = contexts[rand(contexts.length)]
  	if(con)
      @para = con[0] << con[1] << con[2]
      @para.gsub!(word, '___________') #underline the missing word
      
      @multipleChoice = Array.new([word])
      #randomize 4 other vocabulary words
      add = Array.new()
      for w in Word.all(:order=>'RANDOM()', :limit=>3)
        add << w.word
      end
      @multipleChoice += Array.new(add)
      @multipleChoice = @multipleChoice.sort_by{ rand }
    else
      puts "NO CONTEXT!"
      wordlist = game.wordlist.words
      game.currentword = wordlist[rand(wordlist.length)].word
      game.save
      redirect_to(:controller=> :games, :action=> :game_entry, :id => game.id)
    end    
    nexturl = url_for :controller => :games, :action => :game_entry, :id => game.id
    @disp = nexturl
  end

  def new_game
    user_id = 0
  	user_id = current_user.id if(current_user)
  	
  	game = Game.new(:wordlist_id => params[:id], :finished => false, :winner_id => nil)
  	game.save
  	
  	player = GamePlayer.new(:game_id => game.id, :user_id => user_id, :score => 0)
  	
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
  
  def next_word
  end

  def game_page
  end
  	
  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully created.'
        format.html { redirect_to(@game) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
end
