class GamePlayer
	include PIQLEntity
	belongs_to :game
	belongs_to :user
end
