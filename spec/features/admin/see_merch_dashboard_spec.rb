require 'rails_helper'

RSpec.describe "As an Admin user", type: :feature do
  describe "when I visit the merchant index page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)

      admin = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80210",
                            email: "josh@example.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    
    it "I click on a merchant's name and see everything it sees" do
      visit "/merchants"
      
      expect(page).to have_link(@dog_shop.name)
      click_link @bike_shop.name

      expect(current_path).to eq("/admin/merchants/#{@bike_shop.id}")
      
      expect(page).to have_link(@bike_shop.name)
      expect(page).to have_content(@bike_shop.address)
      expect(page).to have_link("All #{@bike_shop.name} Items")
      
      expect(page).not_to have_link(@dog_shop.name)
      expect(page).not_to have_content(@dog_shop.address)
      expect(page).not_to have_link("All #{@dog_shop.name} Items")
    end

  end
end

# User Story 37, Admin can see a merchant's dashboard

# As an admin user
# When I visit the merchant index page ("/merchants")
# And I click on a merchant's name,
# Then my URI route should be ("/admin/merchants/6")
# Then I see everything that merchant would see