class AddLinkproductToProducts < ActiveRecord::Migration
  def change
    add_column :products, :link_product, :string
  end
end
