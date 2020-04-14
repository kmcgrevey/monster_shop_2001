require 'rails_helper'

RSpec.describe "As a merchant employee when I visit my items page" do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @josh = @bike_shop.users.create!(name: "Josh Tukman",
                                     address: "756 Main St",
                                     city: "Denver",
                                     state: "Colorado",
                                     zip: "80210",
                                     email: "josh.t@gmail.com",
                                     password: "secret_password",
                                     password_confirmation: "secret_password",
                                     role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @seat = @bike_shop.items.create(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
    @pump = @bike_shop.items.create(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
    @pedals = @bike_shop.items.create(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
    @helmet = @bike_shop.items.create(name: "Helmet", description: "Safety Third!", price: 100, image: "https://www.rei.com/media/product/153004", inventory: 20)
    @stud = @bike_shop.items.create(name: "Canti Studs", description: "You don't need 'em till you do.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)

  end

  # describe "I see all of my items with the following info" do
  #   it "name, description, price, image, status, inventory" do
  #
  #
  #
  #     # As a merchant employee
  #     # When I visit my items page
  #     # I see all of my items with the following info:
  #     #
  #     # name
  #     # description
  #     # price
  #     # image
  #     # active/inactive status
  #     # inventory
  #
  #   end
  # end
  #
  #   it "I also see a link to deactivate the item next to all active items" do
  #     # I see a link or button to deactivate the item next to each item that is active
  #
  #   end
  #
  #   it "when I click the deactivate button I am redirected back to my items page" do
  #     # And I click on the "deactivate" button or link for an item
  #     # I am returned to my items page
  #   end
  #
  #   it "I also see a flash message saying the item is no longer for sale" do
  #     # I see a flash message indicating this item is no longer for sale
  #   end
  #
  #   it "I see that the item is inactive" do
  #     # I see the item is now inactive
  #   end
end
