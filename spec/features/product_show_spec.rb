require 'rails_helper'

feature 'Product show' do
  given(:user){ create(:user) }
  given!(:product){ create(:product, status: "published") }
  given!(:product_user_login){ create( :product, status: "published", user_id: user.id ) }

  scenario "When show a product with visitor user" do
    visit product_path(product)
    expect(page).to have_content(product.name, product.quantity)
    expect(page).to_not have_content("Edit")
  end

  scenario "when a product  belongs to the user logged in" do
    log_in user
    visit product_path(product_user_login)
    expect(page).to have_content(product_user_login.name, "Edit")
  end

  scenario "When user modifies URL to show a product" do
    visit '/products/1000'
    expect(page).to have_content("Page not found")
  end
end