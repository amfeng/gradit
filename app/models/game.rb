class Game < ActiveRecord::Base
	belongs_to :wordlist
	has_many :game_players

  def answer_choice(answer)
    currentword == answer
  end
end
