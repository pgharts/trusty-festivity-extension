class AddIndexes < ActiveRecord::Migration
  def up
    # add performance indexes
    add_index :festivity_performances, :event_page_id
    add_index :festivity_performances, :location_page_id

    # add category indexes
    add_index :festivity_page_categories, [:page_id, :festivity_category_id], unique: true, name: "event_categories"

  end

  def down
    remove_index :festivity_performances, :event_page_id
    remove_index :festivity_performances, :location_page_id

    # add category indexes
    remove_index :festivity_page_categories, [:page_id, :festivity_category_id], unique: true, name: "event_categories"
  end
end


