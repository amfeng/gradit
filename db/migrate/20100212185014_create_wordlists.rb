class CreateWordlists < ActiveRecord::Migration
  def self.up
    create_table :wordlists do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :wordlists
  end
end
