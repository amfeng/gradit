class DashboardController < ApplicationController
  before_filter :login_required
  
  def index
  	active = current_user.has_active_game
	@game_url = url_for :controller => :games, :action => :game_entry, :id => active.id if active
  	@finished_games = current_user.games
  end
  
  def your_game_player(game)
  	GamePlayer.find(:first, :conditions => {:game_id => game.id, :user_id => current_user.id})
  end

end
