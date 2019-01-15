ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      panel "Recent Products" do
        table_for Product.order("id desc").limit(5).each do |_product|
          column do |product|
            link_to(product.name, admin_product_path(product))
          end
          column :created_at 
          column "Created By", :user
        end
      end
    end
  end
end