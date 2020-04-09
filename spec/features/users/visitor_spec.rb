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
end
