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

  it "does not allow default users to see /merchant or /admin pages" do

    josh = User.create!(name: "Josh Tukman",
                          address: "756 Main St",
                          city: "Denver",
                          state: "Colorado",
                          zip: "80209",
                          email: "josh.t@gmail.com",
                          password: "secret_password",
                          password_confirmation: "secret_password")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)

    # visit "/merchant"
    # expect(page).to_not have_link("Merchant Dashboard")
    # expect(page.status_code).to eq(404)
    # expect(page).to have_content("The page you were looking for doesn't exist.")
    #
    # visit "/admin"
    # expect(page).to_not have_link("Admin Dashboard")
    # expect(page.status_code).to eq(404)
    # expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
