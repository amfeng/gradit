class Intersect
  include PIQLEntity
  def generateChoices
    setA = MultipleChoice.find(seta)
    setB = MultipleChoice.find(setb)

	choicesA = [ setA.choice1, setA.choice2, setA.choice3, setA.choice4 ]
	choicesB = [ setB.choice1, setB.choice2, setB.choice3, setB.choice4 ] 
    return choicesA & choicesB
  end
end
