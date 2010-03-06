class Word < ActiveRecord::Base
  has_and_belongs_to_many :wordlists
  has_many :multiple_choices
  #attr_accessor :multiple_choices
  def choices
    mc = self.multiple_choices
    mc = mc[rand(mc.length)]
    mc = mc.is_intersection ? Intersect.find(mc.intersection_id).generateChoices : mc
  end    
end
