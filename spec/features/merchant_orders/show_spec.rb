require 'rails_helper'

RSpec.describe "As a merchant employee", type: :feature do
  describe "when I visit an order show page from my dashboard" do
    before(:each) do

      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)

      @user = User.create(name: 'User',
                         address: '78 Broadway Ave',
                         city: 'Denver',
                         state: 'CO',
                         zip: "80210",
                         email: 'user@example.com',
                         password: 'user',
                         password_confirmation: 'user',
                         role: 0)

      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @seat = @bike_shop.items.create(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      @pump = @bike_shop.items.create(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
      @pedals = @bike_shop.items.create(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)

      @order1 = @user.orders.create!(name: 'Josh', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)
      @order2 = @user.orders.create!(name: 'Krista', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)
      @order3 = @user.orders.create!(name: 'Mike', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)

      ItemOrder.create!(order_id: @order1.id, item_id: @tire.id, price: @tire.price, quantity: 2)
      ItemOrder.create!(order_id: @order1.id, item_id: @seat.id, price: @seat.price, quantity: 1)
      ItemOrder.create!(order_id: @order2.id, item_id: @pump.id, price: @pump.price, quantity: 1)
      ItemOrder.create!(order_id: @order3.id, item_id: @pull_toy.id, price: @pull_toy.price, quantity: 3)
      ItemOrder.create!(order_id: @order2.id, item_id: @pull_toy.id, price: @pull_toy.price, quantity: 2)
      ItemOrder.create!(order_id: @order2.id, item_id: @tire.id, price: @tire.price, quantity: 5)
      ItemOrder.create!(order_id: @order2.id, item_id: @pedals.id, price: @pedals.price, quantity: 22)
      @josh = @bike_shop.users.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80210",
                            email: "josh@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)
    end
    it 'shows details of each of my items from that order, but no items from any other merchant' do

      visit "/merchant"
      click_link "Order Number: #{@order2.id}"

      expect(current_path).to eq("/merchant/orders/#{@order2.id}")

      expect(page).to have_content(@order2.name)
      expect(page).to have_content(@order2.address)
      expect(page).to have_content(@order2.city)
      expect(page).to have_content(@order2.state)
      expect(page).to have_content(@order2.zip)

      within "#item-#{@pump.id}" do
        expect(page).to have_link "#{@pump.id}", href: "/merchant/items/#{@pump.id}"
        expect(page).to have_css("img[src*='#{@pump.image}']")
        expect(page).to have_content(@pump.price)
        expect(page).to have_content("Quantity: 1")
      end

      within "#item-#{@tire.id}" do
        expect(page).to have_link "#{@tire.id}", href: "/merchant/items/#{@tire.id}"
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content(@tire.price)
        expect(page).to have_content("Quantity: 5")
      end

      expect(page).to_not have_content(@pull_toy.id)
    end


    it 'has a fulfill item button for each unfulfilled item' do

      visit "/merchants/#{@bike_shop.id}/items"
      within "#item-#{@tire.id}" do
        expect(page).to have_content("Inventory: 12")
      end

      visit "/merchant/orders/#{@order2.id}"
      within "#item-#{@pump.id}" do
        expect(page).to have_link "Fulfill Item", href: "/merchant/orders/#{@order2.id}/#{@pump.id}"
      end

      within "#item-#{@pedals.id}" do
        expect(page).to_not have_link "Fulfill Item", href: "/merchant/orders/#{@order2.id}/#{@pedals.id}"
      end

      within "#item-#{@tire.id}" do
        expect(page).to have_content("Unfulfilled")
        click_link "Fulfill Item", href: "/merchant/orders/#{@order2.id}/#{@tire.id}"
      end

      expect(current_path).to eq("/merchant/orders/#{@order2.id}")
      within ".success-flash" do
        expect(page).to have_content("This item has been fulfilled")
      end

      within "#item-#{@tire.id}" do
        expect(page).to have_content("Status: Fulfilled")
        expect(page).to have_content("This item has been fulfilled already")
      end

      within "#item-#{@pedals.id}" do
        expect(page).to have_content("Unfulfilled")
      end

      visit "/merchants/#{@bike_shop.id}/items"
      within "#item-#{@tire.id}" do
        expect(page).to have_content("Inventory: 7")
      end

    end
  end
end




# I see the item is now fulfilled
# I also see a flash message indicating that I have fulfilled that item
# the item's inventory quantity is permanently reduced by the user's desired quantity
# If I have already fulfilled this item, I see text indicating such.
