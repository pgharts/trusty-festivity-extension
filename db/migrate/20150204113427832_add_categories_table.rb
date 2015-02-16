class AddCategoriesTable < ActiveRecord::Migration
  def up
    create_table :festivity_categories do |t|
      t.string :name
      t.integer :festivity_category_type_id
      t.integer :parent_id
      t.integer :position
      t.boolean :inactive, default: false
    end
  end

  def down
    drop_table :festivity_categories
  end
end
