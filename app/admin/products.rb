ActiveAdmin.register Product do

  belongs_to :user, optional: true
  permit_params :name, :description, :quantity, :price, :category_id, :user_id, product_images_attributes: [:id, :image, :_destroy]

  includes :category, :user
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :quantity
    column :price
    column :category
    column :user
    column :status
  end

  filter :name
  filter :price
  filter :category
  filter :user


  show do
    attributes_table do
      row :name
      row :description
      row :quantity
      row :price
      row :category
      row :user
      row :status
      panel " " do
        table_for product.product_images do
          column "Image", :product_images do |image|
            image_tag (image.image.url(:thumb))
          end
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :user
      f.input :name
      f.input :description
      f.input :quantity
      f.input :price
      f.input :status
      f.inputs do
        f.has_many :product_images, heading: "Product Images",
        allow_destroy: true,
        new_record: true do |product_image|
          product_image.input :image
        end
      end
    end
    actions
  end

end
