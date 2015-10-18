class UpdateSiteForHourlyFilters < ActiveRecord::Migration
  def up
    change_column :sites, :festivity_start_date, :datetime
    change_column :sites, :festivity_end_date, :datetime
    add_column :sites, :festivity_filter_type, :string

  end

  def down
    change_column :sites, :festivity_start_date, :date
    change_column :sites, :festivity_end_date, :date
    remove_column :sites, :festivity_filter_type, :string
  end
end
