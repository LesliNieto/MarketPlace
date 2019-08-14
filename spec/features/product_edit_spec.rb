require 'rails_helper'

feature "Edit product" do
  given(:user){ create(:user) }
  given!(:product_user_login){ create( :product, status: "published", user_id: user.id ) }

  scenario "when a product is edited with the required fields filled" do
    log_in user
    visit edit_product_path(product_user_login)
    expect(page).to have_content("Edit Product")
    expect(page).to have_button("Submit")
    fill_in 'Name', with: "New name"
    click_button("Submit")
    expect(page).to have_content("New name")
  end

  scenario "when users edit a product without the required fields" do
    log_in user
    visit edit_product_path(product_user_login)
    expect(page).to have_content("Edit Product")
    expect(page).to have_button("Submit")
    fill_in 'Name', with: nil
    click_button("Submit")
    expect(page).to have_content("Name can't be blank")
  end

end