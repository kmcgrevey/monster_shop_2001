require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @seat = @meg.items.create!(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      @pump = @meg.items.create!(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
      @pedals = @meg.items.create!(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
      @helmet = @meg.items.create!(name: "Helmet", description: "Safety Third!", price: 100, image: "https://www.rei.com/media/product/153004", inventory: 20)
      @stud = @meg.items.create(name: "Canti Studs", description: "You don't need 'em till you do.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @carrier = @brian.items.create!(name: "Carrier", description: "Home away from home", price: 70, image: "https://s7d2.scene7.com/is/image/PetSmart/5168894?$sclp-prd-main_large$", inventory: 32)
      @bed = @brian.items.create!(name: "Doggie Bed", description: "Soo plush and comfy!", price: 40, image: "https://s7d2.scene7.com/is/image/PetSmart/5291324", inventory: 32)
      @dog_food = @brian.items.create!(name: "Bag o Food", description: "Nutrition in bulk", price: 54, image: "https://s7d2.scene7.com/is/image/PetSmart/5149892", inventory: 32)
      @collar = @brian.items.create!(name: "Dog Collar", description: "Choker", price: 18, image: "https://s7d2.scene7.com/is/image/PetSmart/5169886", inventory: 32)
      @brush = @brian.items.create!(name: "Dog Brush", description: "Detangle those curls", price: 12, image: "https://s7d2.scene7.com/is/image/PetSmart/5280398", inventory: 32)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)

    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      expect(page).to_not have_css("#item-#{@dog_bone.id}")

    end

    it "does not show disabled items" do
      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      expect(page).to_not have_css("#item-#{@stud.id}")

      expect(page).to_not have_link(@stud.name)
      expect(page).to_not have_content(@stud.description)
      expect(page).to_not have_content("Inventory: #{@stud.inventory}")
      expect(page).to_not have_css("img[src*='#{@stud.image}']")

    end

    it "I see the 5 most and 5 least popular items with their quantity purchased" do
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

      order = @user.orders.create!(name: 'Josh', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)

      ItemOrder.create!(order_id: order.id, item_id: @tire.id, price: @tire.price, quantity: 11)
      ItemOrder.create!(order_id: order.id, item_id: @seat.id, price: @seat.price, quantity: 10)
      ItemOrder.create!(order_id: order.id, item_id: @pull_toy.id, price: @pull_toy.price, quantity: 9)
      ItemOrder.create!(order_id: order.id, item_id: @pump.id, price: @pump.price, quantity: 8)
      ItemOrder.create!(order_id: order.id, item_id: @pedals.id, price: @pedals.price, quantity: 7)

      ItemOrder.create!(order_id: order.id, item_id: @helmet.id, price: @helmet.price, quantity: 6)
      ItemOrder.create!(order_id: order.id, item_id: @carrier.id, price: @carrier.price, quantity: 5)
      ItemOrder.create!(order_id: order.id, item_id: @bed.id, price: @bed.price, quantity: 4)
      ItemOrder.create!(order_id: order.id, item_id: @dog_food.id, price: @dog_food.price, quantity: 3)
      ItemOrder.create!(order_id: order.id, item_id: @collar.id, price: @collar.price, quantity: 2)
      ItemOrder.create!(order_id: order.id, item_id: @brush.id, price: @brush.price, quantity: 1)

      visit '/items'

      within "#most-popular" do
        expect(page).to have_content("#{@tire.name}: 11")
        expect(page).to have_content("#{@seat.name}: 10")
        expect(page).to have_content("#{@pull_toy.name}: 9")
        expect(page).to have_content("#{@pump.name}: 8")
        expect(page).to have_content("#{@pedals.name}: 7")
      end

      within "#least-popular" do
        expect(page).to have_content("#{@brush.name}: 1")
        expect(page).to have_content("#{@collar.name}: 2")
        expect(page).to have_content("#{@dog_food.name}: 3")
        expect(page).to have_content("#{@bed.name}: 4")
        expect(page).to have_content("#{@carrier.name}: 5")
      end
    end

    it "all item images are links to the items show page" do
      visit '/items'

      expect(page).to_not have_css("#item-#{@stud.id}")

      within "#item-#{@pull_toy.id}" do
        find(:xpath, "//a/img[@alt='Tug toy dog pull 9010 2 800x800']/..").click
      end

      expect(current_path).to eq("/items/#{@pull_toy.id}")

      visit '/items'

      within "#item-#{@tire.id}" do
        find(:xpath, "//a/img[@alt='4e1f5b05 27ef 4267 bb9a 14e35935f218?size=784x588']/..").click
      end

      expect(current_path).to eq("/items/#{@tire.id}")

    end

  end
end
