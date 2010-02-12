class CreateBookLines < ActiveRecord::Migration
  def self.up
    create_table :book_lines do |t|
      t.integer :id
      t.text :line
      t.resource :source

      t.timestamps
    end
  end

  def self.down
    drop_table :book_lines
  end
end
