class DashboardController < ApplicationController
  def index
  	@finished_games = current_user.games
  end
  
  def your_game_player(game)
  	GamePlayer.find(:first, :conditions => {:game_id => game.id, :user_id => current_user.id})
  end

end
