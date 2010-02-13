class AddBookLinenums < ActiveRecord::Migration
  def self.up
    add_column :book_lines, :linenum, :integer
  end

  def self.down
    remove_column :book_lines, :linenum
  end
end
