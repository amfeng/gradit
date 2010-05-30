class CreateGlobalIds < ActiveRecord::Migration
  def self.up
    create_table :global_ids, :id => false do |t|
      t.integer :counter
      t.timestamps
    end
  end

  def self.down
    drop_table :global_ids
  end
end
