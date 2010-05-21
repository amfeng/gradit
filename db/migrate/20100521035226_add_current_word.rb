class AddCurrentWord < ActiveRecord::Migration
  def self.up
    add_column :games, :currentword, :string
  end

  def self.down
    remove_column :games, :currentword
  end
end
