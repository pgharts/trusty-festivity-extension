class AddSiteFields < ActiveRecord::Migration
  def up
    add_column :sites, :box_office_phone_number, :string
    add_column :sites, :google_search_api_key, :string
  end

  def down
    remove_column :sites, :box_office_phone_number
    remove_column :sites, :google_search_api_key
  end
end
