require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I click on the 'register' link in the nav bar" do
    it "takes me to the user registration page" do
      visit "/merchants"
      within ".topnav" do
        click_link "Register"
      end
      expect(current_path).to eq("/users/new")
    end
    it "lets me complete a new registration form" do
      visit "/users/new"
        fill_in :name, with: "Josh Tukman"
        fill_in :address, with: "756 Main St"
        fill_in :city, with: "Denver"
        fill_in :state, with: "Colorado"
        fill_in :zip, with: "80209"
        fill_in :email, with: "josh.t@gmail.com"
        fill_in :password, with: "secret_password"
        fill_in :password_confirm, with: "secret_password"

        click_button "Register"
        expect(current_path).to eq("/profile")
        within ".success-flash" do
          expect(page).to have_content("You are now registered and logged in!")
        end

    end
  end
end


  # And I see a form where I input the following data:
  #
  # my name
  # my street address
  # my city
  # my state
  # my zip code
  # my email address
  # my preferred password
  # a confirmation field for my password
  # When I fill in this form completely,
  # And with a unique email address not already in the system
  # My details are saved in the database
  # Then I am logged in as a registered user
  # I am taken to my profile page ("/profile")
  # I see a flash message indicating that I am now registered and logged in
