class Game
	include PIQLEntity
	belongs_to :wordlist
	has_many :game_players
	has_many :users, :through => :game_players

  def answer_choice(answer)
    currentword == answer
  end
  
end
