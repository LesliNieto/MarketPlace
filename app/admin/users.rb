ActiveAdmin.register User do
  menu priority: 3

  permit_params :first_name, :last_name, :email, :cellphone, :address, :password, :password_confirmation,
  products_attributes: [:id, :name, :description, :quantity, :price, :category_id, :_destroy]

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :address
  end

  filter :first_name
  filter :last_name
  filter :address

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :cellphone
      row :address
      row :created_at
      row :updated_at
    end
    panel "Products" do
      table_for user.products do
        column "name", :name do |product|
          link_to product.name, admin_product_path(product)
        end
        column :description
        column :price
        column :quantity
        column :category
        column :status
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :cellphone
      f.input :address
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.inputs do
        f.has_many :products, heading: "Products",
        allow_destroy: true,
        new_record: true do |product|
          product.input :name
          product.input :description
          product.input :quantity
          product.input :price
          product.input :category
        end
      end
    end
    f.actions
  end
end
