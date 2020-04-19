require 'rails_helper'

RSpec.describe "As a merchant employee" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @seat = @meg.items.create!(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      @pedals = @meg.items.create!(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
      @stud = @meg.items.create(name: "Canti Studs", description: "You don't need 'em till you do.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)

      @discount_1 = @tire.discounts.create(description: "25% off 4 or More", discount_amount: 0.25, minimum_quantity: 4)
      @discount_2 = @pedals.discounts.create(description: "10% off 2 or More", discount_amount: 0.10, minimum_quantity: 2)
      @discount_3 = @stud.discounts.create(description: "50% off 10 or More", discount_amount: 0.50, minimum_quantity: 10)
      @discount_4 = @tire.discounts.create(description: "50% off 8 or More", discount_amount: 0.50, minimum_quantity: 8)

      @employee = @meg.users.create!(name: 'Merchant Employee',
                       address: '456 Main St',
                       city: 'Townsburg',
                       state: 'CA',
                       zip: "98765",
                       email: 'merchant@example.com',
                       password: 'password_merchant',
                       password_confirmation: 'password_merchant',
                       role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)
    end

    it "I can update my discounts" do

    visit "/merchant/items/discounts/#{@discount_1.id}"

    click_link "Update Discount"

    expect(current_path).to eq("/merchant/items/discounts/#{@discount_1.id}/edit")

    fill_in "Description", with: "75% off 6 or More"
    fill_in "Discount amount", with: "0.75"
    fill_in "Minimum quantity", with: "6"
    click_button "Update Discount"

    expect(current_path).to eq("/merchant/items/discounts/#{@discount_1.id}")

    expect(page).to have_content("75% off 6 or More")
    expect(page).to have_content("Discount Amount 0.75")
    expect(page).to have_content("Minimum Quantity Required for Discount: 6")

  end
end
