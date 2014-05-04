class ChangeColumnToProducts < ActiveRecord::Migration
  def change
    change_column :products, :offer, :boolean, default: :false
    change_column :products, :promotion, :boolean, default: :false
  end
end
