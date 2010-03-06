class AddScoreToMultipleChoice < ActiveRecord::Migration
  def self.up
    add_column :multiple_choices, :score, :integer
  end

  def self.down
    remove_column :multiple_choices, :score
  end
end
