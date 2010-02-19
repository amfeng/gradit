class FixWordlistsWordsJoinTable2 < ActiveRecord::Migration
  def self.up
    drop_table :wordlists_words
    create_table :wordlists_words, {:id => false} do |t|
	   t.integer :word_id
	   t.integer :wordlist_id
	 end
  end

  def self.down
     drop_table :wordlists_words
	 create_table :wordlists_words do |t|
	   t.integer :word_id
	   t.integer :wordlist_id
	 end
  end
end
