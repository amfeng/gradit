class CreateWrongChoices < ActiveRecord::Migration
  def self.up
    create_table :wrong_choices do |t|
      t.integer :wrong_choice_id
      t.resources :word
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :wrong_choices
  end
end
