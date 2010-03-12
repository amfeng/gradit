class AddWrongChoicesToWord < ActiveRecord::Migration
  def self.up
    add_column :wrong_choices, :word_id, :integer
  end

  def self.down
    remove_column :wrong_choices, :word_id
  end
end
