class AddPerformancesTable < ActiveRecord::Migration
  def up

    create_table :festivity_performances  do |t|
      t.integer  :event_page_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer  :location_page_id
      t.string   :notes, default: ""
      t.timestamps null: false
    end
  end

  def down
    drop_table :festivity_performances
  end
end


