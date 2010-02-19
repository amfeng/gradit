class Game < ActiveRecord::Base
	belongs_to :wordlist
	has_many :game_players
end
