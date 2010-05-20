class AddWordIdToContexts < ActiveRecord::Migration
  def self.up
    add_column :contexts, :word_id, :integer
  end

  def self.down
    remove_column :contexts, :word_id
  end
end
