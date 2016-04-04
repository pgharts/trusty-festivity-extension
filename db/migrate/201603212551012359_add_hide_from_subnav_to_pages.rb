class AddHideFromSubnavToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :hide_from_subnav, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :hide_from_subnav
  end
end