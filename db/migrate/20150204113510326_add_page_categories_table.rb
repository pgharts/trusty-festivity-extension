class AddPageCategoriesTable < ActiveRecord::Migration
  def up
    create_table :page_categories do |t|
      t.integer :page_id
      t.integer :category_id
    end
  end

  def down
    drop_table :page_categories
  end
end
