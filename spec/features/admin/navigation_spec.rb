require 'rails_helper'

RSpec.describe "As an Admin", type: :feature do
  describe "within the nav bar" do
    before(:each) do
      @user_1 = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@example.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 2)
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "/merchants"
    end
    
    it "I see the same links as a regular user" do
      
      within ".topnav" do
        click_link "Profile" 
      end
      
      expect(current_path).to eq("/profile")
      
      within ".topnav" do
        click_link "All Merchants" 
      end
      
      expect(current_path).to eq("/merchants")
      
      within ".topnav" do
        click_link "All Items" 
      end
      
      expect(current_path).to eq("/items")
      
      within ".topnav" do
        click_link "Logout"
      end
    end

    it "I also see my admin only links" do

      within ".topnav" do
        click_link "Admin Dashboard" 
      end
      
      expect(current_path).to eq("/admin/dashboard")

      within ".topnav" do
        click_link "All Users" 
      end
      
      expect(current_path).to eq("/admin/users")
      
      within ".topnav" do
        expect(page).not_to have_link("Cart: 0")
      end
      
      within ".topnav" do
        expect(page).not_to have_link("Register")
      end
    end

    it 'if I try to visit a merchant route I get an error' do
      visit "/merchant/dashboard"

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    
    it 'if I try to visit a cart route I get an error' do
      visit "/cart"

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    
  
  end
end

# '/merchant'
# '/cart'