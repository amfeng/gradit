class MultipleChoice
  include PIQLEntity
  belongs_to :word
  
  def getChoices
    mc = [choice1,choice2,choice3,choice4].sort_by{ rand }
  end
end
