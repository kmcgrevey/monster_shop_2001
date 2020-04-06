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
  end
end

  # As a visitor
  # When I click on the 'register' link in the nav bar
  # Then I am on the user registration page ('/register')
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
