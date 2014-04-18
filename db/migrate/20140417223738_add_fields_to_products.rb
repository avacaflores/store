class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :part_number, :string
    add_column :products, :min_price, :integer
  end
end
