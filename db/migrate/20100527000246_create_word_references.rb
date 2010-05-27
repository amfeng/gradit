class CreateWordReferences < ActiveRecord::Migration
  def self.up
    create_table :word_references, :id => false do |t|
      t.integer :word
      t.integer :bookline

      t.timestamps
    end
  end

  def self.down
    drop_table :word_references
  end
end
