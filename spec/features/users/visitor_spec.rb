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

    # it "has a link to Merchants page that when clicked renders 404 error" do
    #   visit '/items'
    #   within '.topnav' do
    #     click_link 'All Merchants'
    #     expect(page.status_code).to eq(404)
    #   end
    # end

    it "has a link to Cart" do
      visit '/'
      within '.topnav' do
        expect(page).to have_link "Cart: 0"
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
        expect(current_path).to eq('/login')
      end
    end
  end

  describe "sees a 404 error" do
  #   it "when trying to access /admin" do
  #     visit "/admin"
  #     expect(page.status_code).to eq(404)
  #   end

    it "when trying to access /profile" do
      visit "/profile"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
