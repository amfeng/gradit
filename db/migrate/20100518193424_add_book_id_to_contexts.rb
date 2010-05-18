class AddBookIdToContexts < ActiveRecord::Migration
  def self.up
    add_column :contexts, :book_id, :integer
  end

  def self.down
    remove_column :contexts, :book_id
  end
end
