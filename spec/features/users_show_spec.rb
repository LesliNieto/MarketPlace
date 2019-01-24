require 'rails_helper'

feature "Visiting the user show" do

  given(:user) { create(:user) }

  scenario "when a user modifies URL" do
    log_in user
    visit 'users/1'
    expect(page).to have_content("Page not found")
  end

  scenario "when uses on click on 'Profile'" do
    log_in user
    click_link 'Profile'
    expect(page).to have_content(user.name, user.address)
    expect(page).to have_button("Cancel my account")
  end

  scenario "when your select a user from the list" do
    log_in user
    click_link 'Users'
    expect(page).to have_content("User")
    click_link user.name
    expect(page).to have_content(user.name, "¿UnHappy?")
    expect(page).to have_button("Cancel my account")
  end

end
