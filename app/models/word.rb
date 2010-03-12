class Word < ActiveRecord::Base
  has_and_belongs_to_many :wordlists
  has_many :multiple_choices
  has_many :wrong_choices
  #attr_accessor :multiple_choices
  def choices
    mc = self.multiple_choices
    mc = mc[rand(mc.length)]
    mclist = []
	# add wrong choices, if any
	if (mc)
      if (mc.is_intersection)
        mclist = Intersect.find(mc.intersection_id).generateChoices
      else
        mclist = [ mc.choice1, mc.choice2, mc.choice3, mc.choice4 ]
      end
      if (self.wrong_choices.length > 0 && mclist.length<4)
        mclist = [self.wrong_choices[rand(4)]]
      end
    end
	allwords = Word.all(:order=>'RANDOM()', :limit=>4)
	counter = 0
	while (mclist.length < 4)
	  mclist << allwords[counter]
	  counter = counter + 1
	end
	if (mc.nil? or mc.is_intersection) 
	  MultipleChoice.create(:word_id => self.id, :is_intersection => false, :intersection_id => nil, :choice1 => mclist[0], :choice2 => mclist[1], :choice3 => mclist[2], :choice4 => self.word, :score => 20)
	end
	return mclist.sort_by{ rand }
  end    
end
