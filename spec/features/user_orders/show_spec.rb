require 'rails_helper'

RSpec.describe "As a registered user", type: :feature do
    before(:each) do
        @user = User.create!(name: "Josh Tukman",
                              address: "756 Main St.",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80209",
                              email: "josh.t@gmail.com",
                              password: "secret_password",
                              password_confirmation: "secret_password",
                              role: 0)

        @user2 = User.create!(name: "Jane Adams",
                              address: "756 Main St.",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80209",
                              email: "jane@example.com",
                              password: "secret_password",
                              password_confirmation: "secret_password",
                              role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @order1 = @user.orders.create!(name: 'Josh', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345, status: 1)
      @order2 = @user.orders.create!(name: 'Kevin', address: '123 Kevin Ave', city: 'Denver', state: 'CO', zip: 80222, status: 1)
      @order3 = @user2.orders.create!(name: 'Jane', address: '123 Jane Drive', city: 'Boulder', state: 'CO', zip: 80301)

      @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)

      @order2.item_orders.create!(item: @tire, price: @tire.price, quantity: 3)
      @order2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 1)
    end

    it "they can visit their profile page and click a link to their orders show page" do
      visit "/profile"
        click_link "My Orders"
        expect(current_path).to eq("/profile/orders")
    end

    it "they can visit the order show page and see every order and all of each orders details" do

      visit "/profile/orders"

      within "#order-#{@order1.id}" do
      expect(page).to have_link "Order Number: #{@order1.id}", href: "/orders/#{@order1.id}"
      expect(page).to have_content(@order1.created_at.to_date)
      expect(page).to have_content(@order1.updated_at.to_date)
      expect(page).to have_content(@order1.status)
      expect(page).to have_content("Total Count: 5")
      expect(page).to have_content("Grandtotal: $230")
      end

      within "#order-#{@order2.id}" do
      expect(page).to have_link "Order Number: #{@order2.id}", href: "/orders/#{@order2.id}"
      expect(page).to have_content(@order2.created_at.to_date)
      expect(page).to have_content(@order2.updated_at.to_date)
      expect(page).to have_content(@order2.status)
      expect(page).to have_content("Total Count: 4")
      expect(page).to have_content("Grandtotal: $310")
      end

      expect(page).to_not have_content(@order3.id)
    end
  end
