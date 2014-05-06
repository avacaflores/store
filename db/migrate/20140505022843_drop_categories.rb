class DropCategories < ActiveRecord::Migration
  def change
    drop_table :categories
    drop_table :categories_products
    drop_table :images
  end
end
