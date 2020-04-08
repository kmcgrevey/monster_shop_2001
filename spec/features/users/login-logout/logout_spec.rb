require 'rails_helper'

RSpec.describe "As any registered user" do
  describe "As a default user" do
    it "can log out of the system" do
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
      click_link "Logout"
      expect(current_path).to eq("/")
      expect(page).to have_content("You are logged out!")
    end
  end
  describe "As a merchant user" do
    it "can log out of the system" do
      user = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)
      visit '/login'
      fill_in :email, with: "josh.t@gmail.com"
      fill_in :password, with: "secret_password"
      click_button "Submit"
      click_link "Logout"
      expect(current_path).to eq("/")
      expect(page).to have_content("You are logged out!")
    end
  end
  describe "As an admin user" do
    it "can log out of the system" do
      user = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 2)
      visit '/login'
      fill_in :email, with: "josh.t@gmail.com"
      fill_in :password, with: "secret_password"
      click_button "Submit"
      click_link "Logout"
      expect(current_path).to eq("/")
      expect(page).to have_content("You are logged out!")
    end
  end
end

# As a registered user, merchant, or admin
# When I visit the logout path
# I am redirected to the welcome / home page of the site
# And I see a flash message that indicates I am logged out
# Any items I had in my shopping cart are deleted
#
#  0
