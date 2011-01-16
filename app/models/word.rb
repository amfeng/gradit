class Word < AvroRecord
  
  #Find word by wordid
  def self.find(id)
    Word.findWord(java.lang.Integer.new(id)) #HACK: call everything twice for piql bug
    w = Word.findWord(java.lang.Integer.new(id))
    puts "***JUST RAN PK QUERY ON WORD***"
    puts w
    return nil if w && w.empty?
    w = w.first unless w == nil || w.empty?
    w = w.first unless w == nil || w.empty?
    w
  end
  
  def self.find_by_name(word)
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
    return ["hello", "goodbye", "yay"] #FIXME
    #Randomly pick 3 other words that are not the same as the current word
  end 
  
  def contexts
    WordContext.contextsForWord(java.lang.Integer.new(self.wordid))
    wc = WordContext.contextsForWord(java.lang.Integer.new(self.wordid)) #HACK: call everything twice for piql bug
    puts "***JUST CALLED WORD.CONTEXTS***"
    puts wc
    wc = wc.first unless wc == nil || wc.empty?
    wc
  end

end
