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

    it "I can visit the order show page from my order index page and see an individual orders details" do
        visit "/profile/orders"
        click_link "Order Number: #{@order1.id}"
        expect(current_path).to  eq("/profile/orders/#{@order1.id}")

        expect(page).to have_content("Order Number: #{@order1.id}")
        expect(page).to have_content(@order1.created_at.to_date)
        expect(page).to have_content(@order1.updated_at.to_date)
        expect(page).to have_content(@order1.status)


          expect(page).to have_content("Gatorskins")
          expect(page).to have_content("Description: They'll never pop!")
          expect(page).to have_css("img[src*='#{@tire.image}']")
          expect(page).to have_content("Quantity Ordered: 2")
          expect(page).to have_content("Price (each): $100")
          expect(page).to have_content("Subtotal: $200")


          expect(page).to have_content("Pull Toy")
          expect(page).to have_content("Description: Great pull toy!")
          expect(page).to have_css("img[src*='#{@tire.image}']")
          expect(page).to have_content("Quantity Ordered: 3")
          expect(page).to have_content("Price (each): $10")
          expect(page).to have_content("Subtotal: $30")

        expect(page).to have_content("Total Count of Items: 5")
        expect(page).to have_content("Grandtotal: $230")

        expect(page).to_not have_content(@order2.id)
    end

    it "I can cancel my order" do
      visit "/profile/orders/#{@order1.id}"
      click_link "Cancel This Order"

      expect(current_path).to eq("/profile")
      within ".success-flash" do
        expect(page).to have_content("Your order has been cancelled")
      end

      visit "/profile/orders"
        within "#order-#{@order1.id}" do
          expect(page).to have_content("Status: cancelled")
          expect(page).to_not have_content("Status: pending")
        end

    end


  end
