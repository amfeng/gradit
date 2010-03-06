class Intersect < ActiveRecord::Base
  def generateChoices
    choicesA = MultipleChoice.find(seta)
    choicesB = MultipleChoice.find(setb)
    return choicesA & choicesB
  end
end
