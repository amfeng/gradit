class Context < ActiveRecord::Base
	belongs_to :book
	belongs_to :word
end
