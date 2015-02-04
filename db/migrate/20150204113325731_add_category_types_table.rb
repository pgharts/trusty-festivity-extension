class AddCategoryTypesTable < ActiveRecord::Migration
  def up
    create_table :festivity_category_types do |t|
      t.string :name
      t.integer :site_id
      t.boolean :inactive, default: false
    end
  end

  def down
    drop_table :festivity_category_types
  end
end
