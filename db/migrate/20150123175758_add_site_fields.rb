class AddSiteFields < ActiveRecord::Migration
  def up
    add_column :sites, :festivity_start_date, :date
    add_column :sites, :festivity_end_date, :date
    add_column :sites, :festivity_festival_name, :string
    add_column :sites, :festivity_google_api_key, :string
  end

  def down
    remove_column :sites, :festivity_start_date
    remove_column :sites, :festivity_end_date
    remove_column :sites, :festivity_festival_name
    remove_column :sites, :festivity_google_api_key
  end
end
