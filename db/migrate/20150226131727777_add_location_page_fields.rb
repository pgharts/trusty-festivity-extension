class AddLocationPageFields < ActiveRecord::Migration
  def up

    add_column :pages, :festivity_address, :string
    add_column :pages, :festivity_city, :string
    add_column :pages, :festivity_state, :string
    add_column :pages, :festivity_zip, :string
    add_column :pages, :festivity_directions_link, :string
  end

  def down

    remove_column :pages, :festivity_address
    remove_column :pages, :festivity_city
    remove_column :pages, :festivity_state
    remove_column :pages, :festivity_zip
    remove_column :pages, :festivity_directions_link
  end
end
