class CreateVanityUrlPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :vanity_url, :string
    add_column :pages, :target_url, :string
  end

  def self.down
    remove_column :pages, :vanity_url
    remove_column :pages, :target_url
  end
end
