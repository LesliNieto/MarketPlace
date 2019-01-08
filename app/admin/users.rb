ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  menu priority: 3

  actions :all, except: [:new, :edit]

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

end
