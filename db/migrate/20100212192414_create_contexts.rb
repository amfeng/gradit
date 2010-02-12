class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.word :string
      t.before :text
      t.after :text

      t.timestamps
    end
  end

  def self.down
    drop_table :contexts
  end
end
