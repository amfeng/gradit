class Word < ActiveRecord::Base
  has_and_belongs_to_many :wordlists
  has_many :multiple_choices
  #attr_accessor :multiple_choices
  def choices
    mc = multiple_choices
    mc = mc[rand(mc.length)]
    mc = Intersect.find(mc.intersection_id).generateChoices if mc.is_intersection
  end    
end
