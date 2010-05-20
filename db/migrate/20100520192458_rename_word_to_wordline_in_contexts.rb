class RenameWordToWordlineInContexts < ActiveRecord::Migration
  def self.up
  	rename_column :contexts, :word, :wordline
  end

  def self.down
  	rename_column :contexts, :wordline, :word
  end
end
