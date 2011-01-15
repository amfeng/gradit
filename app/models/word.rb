class Word < AvroRecord
  
  #Find word by wordid
  def self.findWord(id)
    Word.findWord(java.lang.Integer.new(id))
  end
  
  def self.findWordByWord(word)
    Word.findWordByWord(word)
  end
  
  #Returns a random word
  def self.randomWord
    #Pick a random number from the words available
    random = 1 #FIXME
    Word.findWord(java.lang.Integer.new(random))
  end
  
  #Returns an array of 3 other multiple choice options
  def choices
    #Randomly pick 3 other words that are not the same as the current word
  end 
  
  def contexts
    WordContext.contextsForWord(java.lang.Integer.new(self.wordid))
  end

end
