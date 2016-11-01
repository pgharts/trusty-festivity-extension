class AddContentEditorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :content_editor, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :users, :content_editor
  end
end