require 'rails_helper'

feature "Visiting the view edit user" do

  given(:user) { create(:user) }

  scenario "when a user update the data" do
    log_in user
    visit 'users/edit'
    expect(page).to have_content("Edit")
    expect(page).to have_button("Update")
    fill_in 'Last name', with: 'Peña'
    fill_in 'Current password', with: "123456789"
    click_button 'Update'
    expect(page).to have_content("Your account has been updated successfully.")
    click_link 'Profile'
    expect(page).to have_content("Peña")
  end

  scenario "when a user update with empty fields" do
    log_in user
    visit 'users/edit'
    expect(page).to have_content("Edit")
    expect(page).to have_button("Update")
    fill_in 'Last name', with: nil
    fill_in 'Current password', with: nil
    click_button 'Update'
    expect(page).to have_content("Last name can't be blank", "Current password can't be blank")
  end

end