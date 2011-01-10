
class Word < AvroRecord
  #has_and_belongs_to_many :wordlists
  #has_many :contexts
  #has_many :multiple_choices
  #has_many :wrong_choices
  #has_one :context_cache
  #attr_accessor :multiple_choices
  #attr_accessor :wrong_choices
  

  #adds to the list of attractive distractors associated with this
  #word. 
  #params: wrong_choice is a String object
  def add_wrong_choice(wrong_choice)
    wrong_word = Word.find_by_word(wrong_choice)
    existing_wrong_choices = self.wrong_choices 
    #attractive_distractors = existing_wrong_choices.map{|x| Word.find(x.wrong_choice_id)}

    #if !wrong_word.nil?
    if existing_wrong_choices.map{|x| x.wrong_choice_id}.include?(wrong_word.id)
      wc = existing_wrong_choices.select{|x| x.wrong_choice_id == wrong_word.id}.pop
      wc.puts("count", wc.count + 1)
      wc.save
    else
      w = WrongChoice.new
      w.puts("wrong_choice_id", wrong_word.id)
      w.puts("count", 1)
      #NEED TO CHANGE THE FOLLOWING LINE
      self.wrong_choices << w
    end
  end
    
  def choices(entity_id)
    #mc = self.multiple_choices
    #mc = mc[rand(mc.length)]
    mclist = []
	# add wrong choices, if any

	#if (mc)
    #  if (mc.is_intersection)
    #    mclist = Intersect.find(mc.intersection_id).generateChoices
    #  else
    #    mclist = [ mc.choice1, mc.choice2, mc.choice3, mc.choice4 ]
    #  end
    #  if (self.wrong_choices.length > 0 && mclist.length<4)
    #    mclist = [self.wrong_choices[rand(4)]]
    #  end
    #end
	
    puts "wrong choices"
    wrongchoices = self.wrongChoicesFromWord(5, $piql_env).to_a
    puts wrongchoices
    if(wrongchoices == nil)
    	wrongchoices = Array.new
	end
    if (wrongchoices.length > 0)
      #generate one attractive distractor if there are wrong choices (attractive distractors) available
      r1 = rand(wrongchoices.length)
      mclist << wrongchoices[r1]
      wrongchoices.delete_at(r1)
      if (wrongchoices.length>0)
        r2 = rand(wrongchoices.length)
        mclist << wrongchoices[r2]
        wrongchoices.delete_at(r2)
      end
    end
    
    puts "all words"
    #allwords = Query.allWord.to_a
    #ALL WORDS QUICK HACK..WAITING FOR A WORKAROUND
    allwords = Array.new
    allwords << Query.wordByWord("vex").first
    allwords << Query.wordByWord("indulged").first
    allwords << Query.wordByWord("discerned").first
    allwords << Query.wordByWord("chastened").first
	allwords << Query.wordByWord("abide").first
    allwords << Query.wordByWord("abjured").first
    allwords << Query.wordByWord("alleviation").first
    allwords << Query.wordByWord("ascribed").first
	allwords << Query.wordByWord("benign").first
    allwords << Query.wordByWord("dissented").first
    allwords << Query.wordByWord("eloquence").first
    allwords << Query.wordByWord("hollow").first
	allwords << Query.wordByWord("perilous").first
    allwords << Query.wordByWord("slate").first
    allwords << Query.wordByWord("verdant").first
    allwords << Query.wordByWord("absurd").first
    puts allwords
    allwords = allwords.sort_by {rand}
	puts "AFTER SORTED" 
	puts allwords
    
    counter = 0
    while (mclist.length < 4)
	  w = allwords[counter]
      mclist << w.word if(w != self)
      counter = counter + 1
    end
    #if (mc.nil? or mc.is_intersection) 
    mc_new = MultipleChoice.new
    #NEED TO ADD multiple_choice_id
    mc_new.put("multiple_choice_id", java.lang.Integer.new(entity_id))
    mc_new.put("word_word", self)
    mc_new.put("is_intersection", false)
    mc_new.put("choice1", mclist[0])
    mc_new.put("choice2", mclist[1])
    mc_new.put("choice3", mclist[2])
    mc_new.put("choice4", self.word)
    mc_new.put("score", java.lang.Integer.new(0))
    mc_new.save($piql_env)
    #WHAT IS MultipleChoice.word_word? NEED TO ADD THAT

    #end
    #retlist = []
    #retlist << mclist[0] << mclist[1] << mclist[2] << self.word
    #return retlist.sort_by{ rand }
    return mc_new
  end    
end
