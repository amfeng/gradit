class CreateWordWordlistsJoinTable < ActiveRecord::Migration
  def self.up
     create_table :words_wordlists do |t|
	   t.integer :word_id
	   t.integer :wordlist_id
	 end
  end

  def self.down
     drop_table :words_wordlists
  end
end
