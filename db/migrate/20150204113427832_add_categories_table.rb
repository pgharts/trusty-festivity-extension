class AddCategoriesTable < ActiveRecord::Migration
  def up
    create_table :festivity_categories do |t|
      t.string :name
      t.integer :category_type_id
      t.integer :parent_category_id
      t.boolean :inactive, default: false
    end
  end

  def down
    drop_table :festivity_categories
  end
end
