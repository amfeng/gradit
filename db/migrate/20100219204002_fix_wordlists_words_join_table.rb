class FixWordlistsWordsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :wordlists_words do |t|
	   t.integer :word_id
	   t.integer :wordlist_id
	 end
	drop_table :words_wordlists
  end

  def self.down
     drop_table :wordlists_words
	 create_table :words_wordlists do |t|
	   t.integer :word_id
	   t.integer :wordlist_id
	 end
  end
end
