class AddIntersectionToMultipleChoice < ActiveRecord::Migration
  def self.up
    add_column :multiple_choices, :is_intersection, :boolean
	add_column :multiple_choices, :intersection_id, :integer
  end

  def self.down
    remove_column :multiple_choices, :is_intersection
    remove_column :multiple_choices, :intersection_id
  end
end
