require 'rails_helper'

RSpec.describe "as a user in the nav bar" do
  it "I see the same links as a visitor" do

  end

  it "I also see links to my profile page '/profile' and to log out '/logout'" do

    visit "/register"

    within ".topnav" do
      expect(page).to_not have_content("Profile")
      expect(page).to_not have_content("Logout")
    end

      fill_in :name, with: "Josh Tukman"
      fill_in :address, with: "756 Main St"
      fill_in :city, with: "Denver"
      fill_in :state, with: "Colorado"
      fill_in :zip, with: "80209"
      fill_in :email, with: "josh.t@gmail.com"
      fill_in :password, with: "secret_password"
      fill_in :password_confirmation, with: "secret_password"


      click_button "Register"

      visit("/merchants")

      within ".topnav" do
        expect(page).to have_link "Profile"
      end

      within ".topnav" do
        expect(page).to have_link "Logout"
      end

  end
end
