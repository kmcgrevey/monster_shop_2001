require 'rails_helper'

RSpec.describe "As an Admin user", type: :feature do
  describe "when I visit the merchant index page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)

      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @seat = @bike_shop.items.create!(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      
      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
     
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
      
      expect(page).to have_content("#{@bike_shop.name} Items")
      expect(page).to have_content("#{@tire.name}")
      expect(page).to have_content("#{@seat.name}")
      
      expect(page).not_to have_content("#{@dog_shop.name} Items")
      expect(page).not_to have_content("#{@pull_toy.name}")
    end

  end
end

# User Story 37, Admin can see a merchant's dashboard

# As an admin user
# When I visit the merchant index page ("/merchants")
# And I click on a merchant's name,
# Then my URI route should be ("/admin/merchants/6")
# Then I see everything that merchant would see