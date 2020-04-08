require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I click on the 'register' link in the nav bar" do
    it "takes me to the user registration page" do
      visit "/merchants"
      within ".topnav" do
        click_link "Register"
      end
      expect(current_path).to eq("/register")
    end
    it "lets me complete a new registration form" do
      visit "/register"
        fill_in :name, with: "Josh Tukman"
        fill_in :address, with: "756 Main St"
        fill_in :city, with: "Denver"
        fill_in :state, with: "Colorado"
        fill_in :zip, with: "80209"
        fill_in :email, with: "josh.t@gmail.com"
        fill_in :password, with: "secret_password"
        fill_in :password_confirmation, with: "secret_password"

        click_button "Register"
        expect(current_path).to eq("/profile")
        within ".success-flash" do
          expect(page).to have_content("You are now registered and logged in!")
        end
      end

      it "if I don't fill in all fields I see a flash message and returned to the registration page" do
        visit "/register"

        fill_in :name, with: "Josh Tukman"
        fill_in :address, with: ""
        fill_in :city, with: "Denver"
        fill_in :state, with: "Colorado"
        fill_in :zip, with: "80209"
        fill_in :email, with: ""
        fill_in :password, with: "secret_password"
        fill_in :password_confirmation, with: "secret_password"

        click_button "Register"

        expect(current_path).to eq("/register")

        within ".error-flash" do
          expect(page).to have_content("Email can't be blank and Address can't be blank")
        end
      end

      it "if I don't fill in all fields I am redirected back but don't lose my entered data" do
        visit "/register"

        fill_in :name, with: "Josh Tukman"
        fill_in :address, with: ""
        fill_in :city, with: "Denver"
        fill_in :state, with: ""
        fill_in :zip, with: "80209"
        fill_in :email, with: "josh.t@gmail.com"
        fill_in :password, with: "secret_password"
        fill_in :password_confirmation, with: "secret_password"

        click_button "Register"

        expect(current_path).to eq("/register")

        expect(find_field(:name).value).to eq "Josh Tukman"
        expect(find_field(:address).value).to eq ""
        expect(find_field(:city).value).to eq "Denver"
        expect(find_field(:state).value).to eq ""
        expect(find_field(:zip).value).to eq "80209"
        expect(find_field(:email).value).to eq nil
        expect(find_field(:password).value).to eq nil
        expect(find_field(:password_confirmation).value).to eq nil

      end

      it "if I fill out a registration form with an email already in the system" do
        user_1 = User.create!(name: "Josh Tukman",
                              address: "756 Main St",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80209",
                              email: "josh.t@gmail.com",
                              password: "secret_password",
                              password_confirmation: "secret_password")

      visit "/register"
        fill_in :name, with: "Mike Hernandez"
        fill_in :address, with: "25 Cowboy Way"
        fill_in :city, with: "Denver"
        fill_in :state, with: "Colorado"
        fill_in :zip, with: "80121"
        fill_in :email, with: "josh.t@gmail.com"
        fill_in :password, with: "cowboy_password"
        fill_in :password_confirmation, with: "cowboy_password"

        click_button "Register"

        expect(current_path).to eq("/register")

        within ".error-flash" do
          expect(page).to have_content("Email has already been taken")
        end

      end
    end
  end
