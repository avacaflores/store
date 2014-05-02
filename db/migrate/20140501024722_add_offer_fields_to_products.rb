class AddOfferFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :offer_price, :decimal
    add_column :products, :offer, :boolean
  end
end
