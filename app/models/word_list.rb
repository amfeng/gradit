class WordList < AvroRecord
  
  def self.find(id)
    WordList.findWordList(id)
  end
  
  def words
    WordList.wordsFromWordList(name)
  end
  
end
