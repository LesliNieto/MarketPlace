require 'rails_helper'

feature "Visiting the index of users" do

  scenario "when a user is not logged in" do
    visit '/users'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  given(:user) { create(:user) }

  scenario "when a user is logged in" do
    log_in(user)
    visit '/users'
    expect(page).to have_content(user.email, "Edit")
    expect(page).to have_content(user.name)
  end

end
