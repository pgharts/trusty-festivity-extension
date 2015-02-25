class AddPageCategoriesTable < ActiveRecord::Migration
  def up
    create_table :festivity_page_categories do |t|
      t.integer :page_id
      t.integer :festivity_category_id
    end
  end

  def down
    drop_table :festivity_page_categories
  end
end
