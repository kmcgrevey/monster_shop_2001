require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
    before(:each) do
                            
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)

      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
      @items_in_cart = [@paper,@tire,@pencil]

      @user = User.create!(name: "Josh Tukman",
                           address: "756 Main St.",
                           city: "Denver",
                           state: "Colorado",
                           zip: "80209",
                           email: "josh.t@gmail.com",
                           password: "secret_password",
                           password_confirmation: "secret_password",
                           role: 0)
      
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
   end
    
    it 'Theres a link to checkout if you are a user and logged in' do
      visit "/cart"

      expect(page).to have_link("Checkout")

      click_on "Checkout"

      expect(current_path).to eq("/orders/new")
    end

    it "I can complete an order form and place my order" do
      visit "/orders/new"

      fill_in :name, with: @user.name
      fill_in :address, with: @user.address
      fill_in :city, with: @user.city
      fill_in :state, with: @user.state
      fill_in :zip, with: @user.zip
      click_button "Create Order"

      expect(current_path).to eq("/profile/orders")

      order = Order.last

      expect(order.name).to eq("Josh Tukman")
      expect(order.status).to eq("Pending")

      within ".success-flash" do
        expect(page).to have_content("Your order was created!")
      end
      expect(page).to have_content(order.id)

      visit '/cart'
      expect(page).to have_content("Cart is currently empty")
    end
  end
  
  describe 'When I havent added items to my cart' do
    it 'There is not a link to checkout' do
      visit "/cart"

      expect(page).to_not have_link("Checkout")
    end
  end
end
