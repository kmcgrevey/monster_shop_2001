require 'rails_helper'

RSpec.describe "as a registered user when I visit my profile page", type: :feature do
  it "I see all of my profile data except my password and a link to edit my profile" do

    user = User.create!(name: "Josh Tukman",
                          address: "756 Main St",
                          city: "Denver",
                          state: "Colorado",
                          zip: "80209",
                          email: "josh.t@gmail.com",
                          password: "secret_password",
                          password_confirmation: "secret_password",
                          role: 0)
    visit '/login'

    fill_in :email, with: "josh.t@gmail.com"
    fill_in :password, with: "secret_password"
    click_button "Submit"
    expect(current_path).to eq("/profile")

    expect(page).to have_content("Welcome #{user.name}!")

    within ".user-info" do
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{user.email}")

      within ".profile-edit-button" do
        expect(page).to have_content("Edit Profile")
      end
    end
  end
end
