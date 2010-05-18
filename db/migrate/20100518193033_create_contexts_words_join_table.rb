class CreateContextsWordsJoinTable < ActiveRecord::Migration
  def self.up
  	 create_table :contexts_words, :id => false do |t|
	   t.integer :context_id
	   t.integer :word_id
	 end
  end

  def self.down
  	drop_table :contexts_words
  end
end
