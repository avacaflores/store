class AddColumnsToProducts < ActiveRecord::Migration
  def change
    remove_column :brands, :product_id
    remove_column :sections, :product_id
  end
end
