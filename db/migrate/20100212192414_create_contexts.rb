class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.string :word
      t.text :before
      t.text :after

      t.timestamps
    end
  end

  def self.down
    drop_table :contexts
  end
end
