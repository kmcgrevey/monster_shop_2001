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
        expect(page).to have_link "Logout"
        expect(page).to_not have_link "Login"
        expect(page).to_not have_link "Register"
      end

    end

  describe "as a merchant employee in the nav bar" do
    it "I see the same links as a regular user and a link to my merchant dashboard" do
      merchant = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit("/merchants")

    within ".topnav" do
      expect(page).to have_link "Profile"
      expect(page).to have_link "Logout"
      click_link "Merchant Dashboard"
      expect(page).to_not have_link "Login"
      expect(page).to_not have_link "Register"
    end

    expect(current_path).to eq("/merchant")
    end
  end

  describe "as a default user" do
    it "does not allow me to see merchant pages" do
      user = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/merchant"

    expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe "as a merchant employee" do
     it "does not allow me to access any path that begins with '/admin' and displays a 404 error" do
       merchant = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit "/admin/dashboard"

    expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  it "does not allow default users to see admin pages" do

    josh = User.create!(name: "Josh Tukman",
                          address: "756 Main St",
                          city: "Denver",
                          state: "Colorado",
                          zip: "80209",
                          email: "josh.t@gmail.com",
                          password: "secret_password",
                          password_confirmation: "secret_password")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)

     visit "/admin/dashboard"
     expect(page).to_not have_link("Admin Dashboard")
     expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
