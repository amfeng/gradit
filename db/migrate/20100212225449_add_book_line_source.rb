class AddBookLineSource < ActiveRecord::Migration
  def self.up
    add_column :book_lines, :source, :resource
  end

  def self.down
    remove_column :book_lines, :source
  end
end
