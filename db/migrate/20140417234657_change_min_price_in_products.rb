class ChangeMinPriceInProducts < ActiveRecord::Migration
  def change
    change_column :products, :min_price, :decimal
  end
end
