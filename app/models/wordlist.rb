class Wordlist < ActiveRecord::Base
   has_and_belongs_to_many Words
end
