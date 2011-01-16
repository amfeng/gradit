class WordList < AvroRecord
  
  def self.find(id)
    begin #HACK: rescue exception
      WordList.findWordList(id) #HACK: call everything twice for piql bug
    rescue Exception => e
      puts "exception was thrown"
      puts e
    end
    wl = WordList.findWordList(id)
    puts "***JUST RAN PK QUERY ON WORDLIST***"
    puts wl
    return nil if w && w.empty?
    wl = wl.first unless wl == nil || wl.empty?
    wl = wl.first unless wl == nil || wl.empty?
    wl
  end
  
  def words
    WordList.wordsFromWordList(name)
  end
  
end
