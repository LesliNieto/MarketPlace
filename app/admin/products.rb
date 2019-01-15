ActiveAdmin.register Product do

  belongs_to :user, optional: true
  permit_params :name, :description, :quantity, :price, :category_id, :user_id

  includes :category, :user
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :quantity
    column :price
    column :status
    column :category
    column :user
  end

  filter :name
  filter :price
  filter :category
  filter :user

end
