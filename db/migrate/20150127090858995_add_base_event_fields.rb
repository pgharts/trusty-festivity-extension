class AddBaseEventFields < ActiveRecord::Migration
  def up

    add_column :pages, :short_description, :string
    add_column :pages, :artist_twitter, :string
    add_column :pages, :artist_facebook, :string
    add_column :pages, :artist_instagram, :string
    add_column :pages, :artist_homepage, :string
    add_column :pages, :header, :string
    add_column :pages, :sub_header, :string
    add_column :pages, :redirect_url, :string
  end

  def down

    remove_column :pages, :short_description
    remove_column :pages, :artist_twitter
    remove_column :pages, :artist_facebook
    remove_column :pages, :artist_instagram
    remove_column :pages, :artist_homepage
    remove_column :pages, :header
    remove_column :pages, :sub_header
  end
end
