class RemoveUrlFromImage < ActiveRecord::Migration
  def change
    remove_column :images, :url
    remove_column :images, :product_image_file_name
    remove_column :images, :product_image_content_type
    remove_column :images, :product_image_file_size
    remove_column :images, :product_image_updated_at
  end
end
