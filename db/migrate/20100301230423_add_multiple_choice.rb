class AddMultipleChoice < ActiveRecord::Migration
  def self.up
    create_table :multiple_choices do |t|
      t.string :choice1
      t.string :choice2
      t.string :choice3
	  t.string :choice4
	  t.integer :word_id
	  t.boolean :is_intersection
	  t.integer :intersection_id
	  t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :multiple_choices
  end
end
