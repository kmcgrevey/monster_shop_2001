require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "Navigation bar" do
    it "has a link to Home Page" do
      visit "/items"
      within '.topnav' do
        click_link 'Home Page'
        expect(current_path).to eq('/')
      end
    end

    it "has a link to Items index page" do
      visit "/"
      within '.topnav' do
        click_link 'All Items'
        expect(current_path).to eq('/items')
      end
    end

    it "has a link to Cart" do
      visit '/'
      within '.topnav' do
        expect(page).to have_link "Cart: 0"
      end
    end

    it "has a link to Merchants" do
      visit '/merchants'
      within '.topnav' do
        expect(page).to have_link "Merchants"
      end
    end

    it "has a link to Registration page" do
      visit '/'
      within '.topnav' do
        expect(page).to have_link "Register"
      end
    end

    it "has a link to Login page" do
      visit '/'
      within '.topnav' do
        click_link "Login"
        expect(current_path).to eq("/login")
      end
    end
  end

  # describe "sees a 404 error" do
  #   it "when trying to access /admin" do
  #     visit "/admin"
  #     expect(page.status_code).to eq(404)
  #   end
  #
  #   it "when trying to access /profile" do
  #     visit "/profile"
  #     expect(page.status_code).to eq(404)
  #   end
  # end
  describe "Login path" do

    it "has a field to enter my email address and password" do
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
        expect(current_path).to eq("/default/profile")
        within ".success-flash" do
          expect(page).to have_content("You are logged in!")
        end
      end
    end
  end


# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in

#As a visitor
# When I try to access any path that begins with the following, then I see a 404 error:
# - '/merchant'
# - '/admin'
# - '/profile'
