class Word < ActiveRecord::Base
  has_and_belongs_to_many :wordlists
  has_many :multiple_choices
end
