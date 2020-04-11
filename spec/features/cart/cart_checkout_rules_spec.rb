require 'rails_helper'

RSpec.describe "When I have items in the cart and I visit the cart", type: :feature do

  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @seat = @bike_shop.items.create(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
  end

  it "I see info saying I need to register or log in to check out" do
    visit "/items"

    within ".topnav" do
      expect(page).to have_content("Cart: 0")
    end

    click_link("#{@tire.name}")
      click_button("Add To Cart")

    within ".topnav" do
      expect(page).to have_content("Cart: 1")
      click_link("Cart: 1")
    end

    expect(page).to have_content("You must register or log in to finish the checkout process.")

  end

  it "the word register is a link to the registration page and login is a link to the login page" do
    visit "/items"

    within ".topnav" do
      expect(page).to have_content("Cart: 0")
    end

    click_link("#{@tire.name}")
      click_button("Add To Cart")

    within ".topnav" do
      expect(page).to have_content("Cart: 1")
      click_link("Cart: 1")
    end

    click_link "register"
      expect(current_path).to eq("/register")

    visit "/cart"

    click_link "log in"
      expect(current_path).to eq("/login")
  end
end
