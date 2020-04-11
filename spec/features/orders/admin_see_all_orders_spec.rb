require 'rails_helper'

RSpec.describe "When I visit the admin dashboard", type: :feature do
  # As an admin user
  # When I visit my admin dashboard ("/admin")

  before(:each) do
    @josh = User.create!(name: "Josh Tukman",
                         address: "756 Main St",
                         city: "Denver",
                         state: "Colorado",
                         zip: "80209",
                         email: "josh.t@gmail.com",
                         password: "secret_password",
                         password_confirmation: "secret_password",
                         role: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)

    @adam = User.create!(name: "Adam Jackson",
                         address: "1215 Jackson St.",
                         city: "Denver",
                         state: "Colorado",
                         zip: "80222",
                         email: "adamfixesthings@gmail.com",
                         password: "toolman",
                         password_confirmation: "toolman",
                         role: 0)

    @mary = User.create!(name: "Mary Stanley",
                         address: "333 E Wonderview Ave",
                         city: "Estes Park",
                         state: "Colorado",
                         zip: "80517",
                         email: "mary@stanley.com",
                         password: "haunted_password",
                         password_confirmation: "haunted_password",
                         role: 0)

    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    @order_1 = @adam.orders.create(name: @adam.name, address: @adam.address, city: @adam.city, state: @adam.state, zip: @adam.zip)

    ItemOrder.create!(order_id: @order_1.id, item_id: @tire.id, price: @tire.price, quantity: 2)

    @order_2 = @mary.orders.create(name: @mary.name, address: @mary.address, city: @mary.city, state: @mary.state, zip: @adam.zip)

    ItemOrder.create!(order_id: @order_2.id, item_id: @paper.id, price: @paper.price, quantity: 1)
    ItemOrder.create!(order_id: @order_2.id, item_id: @pencil.id, price: @pencil.price, quantity: 5)

    visit "/admin/dashboard"

  end

  it "I see all orders in the system" do
    # Then I see all orders in the system.
    expect(page).to have_content("Welcome to the Dashboard #{@josh.name}")

    within(".all-orders") do
      expect(page).to have_content("All Orders:")
    end

    within(".order-#{@order_1.id}") do
      expect(page).to have_content(@order_1.id)
    end

    within(".order-#{@order_2.id}") do
      expect(page).to have_content(@order_2.id)
    end
  end

  it "for each order I see the users name(name links to admin view  of user show page), order id, date created" do
    # For each order I see the following information:
    #
    # user who placed the order, which links to admin view of user profile
    # order id
    # date the order was created
  end

  it "orders are sorted by status in order: packaged pending shipped cancelled" do
    # Orders are sorted by "status" in this order:
    #
    # packaged
    # pending
    # shipped
    # cancelled
  end
end
