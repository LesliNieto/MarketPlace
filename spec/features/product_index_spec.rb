require 'rails_helper'

feature "index" do 
    
  given(:user){ create(:user) }
  given!(:product_1){ create( :product, status: "published" ) }
  given!(:product_user_login){ create( :product, status: "published", user_id: user.id ) }

  scenario "when user is visitor" do
    visit '/products'
    expect(page).to have_content("Products")
    expect(page).to have_content(product_1.name, product_user_login.name)
  end

  scenario "when user is  logged in " do
    log_in user
    visit '/products'
    expect(page).to have_content("Products")
    expect(page).to have_content(product_1.name, product_user_login.name)
    expect(page).to have_content("Archive")
  end

end