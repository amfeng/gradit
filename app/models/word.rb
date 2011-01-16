class Word < AvroRecord
  
  #Find word by wordid
  def self.findWord(id)
    Word.findWord(java.lang.Integer.new(id)).first.first
  end
  
  def self.find_by_name(word)
    Word.findWordByWord(word).first.first
  end
  
  #Returns a random word
  def self.randomWord
    #Pick a random number from the words available
    random = 1 #FIXME
    Word.findWord(java.lang.Integer.new(random)).first.first
  end
  
  #Returns an array of 3 other multiple choice options
  def choices
    #Randomly pick 3 other words that are not the same as the current word
    #FIXME: 1..20 should be the number of words we have
    selectedWordIds = (1..20).sort_by{rand}[1..4] # first four ids are our four words
    selectedWordIds.delete(self.wordid)
    selectedWords = selectedWordIds.map { |wordid| Word.findWord(java.lang.Integer.new(wordid)).first.first }
    selectedWords.shuffle
    return selectedWords
  end 
  
  def contexts
    WordContext.contextsForWord(java.lang.Integer.new(self.wordid)).first
  end

end
