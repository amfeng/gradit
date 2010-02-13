class AddBookLines < ActiveRecord::Migration
  def self.up
    create_table :book_lines do |t|
      t.integer :id
      t.text :line
      t.integer :source
	  t.integer :linenum
      t.timestamps
    end
  end

  def self.down
    drop_table :book_lines
  end
end
