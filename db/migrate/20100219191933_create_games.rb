class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.wordlist :references
      t.finished :boolean
      t.winner_id :integer

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
