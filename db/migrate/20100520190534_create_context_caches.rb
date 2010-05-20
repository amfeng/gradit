class CreateContextCaches < ActiveRecord::Migration
  def self.up
    create_table :context_caches do |t|
      t.references :word
      t.boolean :dirty

      t.timestamps
    end
  end

  def self.down
    drop_table :context_caches
  end
end
