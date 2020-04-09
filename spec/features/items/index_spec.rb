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
      expect(page).to have_link(@dog_bone.name)
      expect(page).to have_link(@dog_bone.merchant.name)
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

      within "#item-#{@dog_bone.id}" do
        expect(page).to have_link(@dog_bone.name)
        expect(page).to have_content(@dog_bone.description)
        expect(page).to have_content("Price: $#{@dog_bone.price}")
        expect(page).to have_content("Inactive")
        expect(page).to have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      end
    end

    it "I see the 5 most and 5 least popular items with their quantity purchased" do
      user = User.create!(name: "Josh Tukman",
                              address: "756 Main St",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80209",
                              email: "josh.t@gmail.com",
                              password: "secret_password",
                              password_confirmation: "secret_password",
                              role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      11.times do
        visit "/items/#{@tire.id}"
        click_on "Add To Cart"
      end

      10.times do
        visit "/items/#{@seat.id}"
        click_on "Add To Cart"
      end

      9.times do
        visit "/items/#{@pull_toy.id}"
        click_on "Add To Cart"
      end

      8.times do
        visit "/items/#{@pump.id}"
        click_on "Add To Cart"
      end

      7.times do
        visit "/items/#{@pedals.id}"
        click_on "Add To Cart"
      end

      6.times do
        visit "/items/#{@helmet.id}"
        click_on "Add To Cart"
      end

      5.times do
        visit "/items/#{@carrier.id}"
        click_on "Add To Cart"
      end

      4.times do
        visit "/items/#{@bed.id}"
        click_on "Add To Cart"
      end

      3.times do
        visit "/items/#{@dog_food.id}"
        click_on "Add To Cart"
      end

      2.times do
        visit "/items/#{@collar.id}"
        click_on "Add To Cart"
      end

      1.times do
        visit "/items/#{@brush.id}"
        click_on "Add To Cart"
      end

      visit "/cart"
      click_on "Checkout"
   
      fill_in :name, with: "Bert"
      fill_in :address, with: "123 Sesame St."
      fill_in :city, with: "NYC"
      fill_in :state, with: "New York"
      fill_in :zip, with: 10001
      
      click_button "Create Order"
      
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
  end
end
