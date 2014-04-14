class FixColumnName < ActiveRecord::Migration
  def change
       rename_column :images, :type, :use
  end
end
