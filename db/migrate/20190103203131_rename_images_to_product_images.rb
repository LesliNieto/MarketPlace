class RenameImagesToProductImages < ActiveRecord::Migration[5.2]
  def change
    rename_table :images, :product_images
  end
end
