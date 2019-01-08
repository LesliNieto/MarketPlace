ActiveAdmin.register Product do

  belongs_to :user, optional: true
  actions :all, except: [:new, :edit]
  permit_params :name, :description, :quantity, :price, :category_id, :user_id

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
  filter :user, collection: -> {
    User.all.map{ |user| [user.first_name, user.id] }
  }

end
