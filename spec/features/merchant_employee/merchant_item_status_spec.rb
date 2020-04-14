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
    @stud = @bike_shop.items.create(name: "Canti Studs", description: "You don't need 'em till you do.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)
    # @seat = @bike_shop.items.create(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
    # @pump = @bike_shop.items.create(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
    # @pedals = @bike_shop.items.create(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
    # @helmet = @bike_shop.items.create(name: "Helmet", description: "Safety Third!", price: 100, image: "https://www.rei.com/media/product/153004", inventory: 20)

  end

  describe "I see all of my items with the following info" do
    it "name, description, price, image, status, inventory" do

      visit "merchant/items"

      within "#item-#{@tire.id}" do
        expect(page).to have_content("#{@tire.name}")
        expect(page).to have_content("#{@tire.description}")
        expect(page).to have_content("#{@tire.price}")
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content("Status: #{@tire.status}")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
      end

      within "#item-#{@stud.id}" do
        expect(page).to have_content("#{@stud.name}")
        expect(page).to have_content("#{@stud.description}")
        expect(page).to have_content("#{@stud.price}")
        expect(page).to have_css("img[src*='#{@stud.image}']")
        expect(page).to have_content("Status: #{@stud.status}")
        expect(page).to have_content("Inventory: #{@stud.inventory}")
      end
    end
  end

    it "I also see a link to deactivate the item next to all active items" do

      visit "merchant/items"

      within "#item-#{@tire.id}" do
        expect(page).to have_link("Deactivate Item")
      end

      within "#item-#{@stud.id}" do
        expect(page).to_not have_link("Deactivate Item")
      end
    end

  describe "when I click the deactivate button I am redirected back to my items page" do
    it "I also see a flash message saying the item is not for sale and it see its status is inactive" do

      visit "/merchant/items"

      within "#item-#{@tire.id}" do
        click_link("Deactivate Item")
      end
      @tire.reload

      expect(current_path).to eq("/merchant/items")
      expect(page).to have_content("'Gatorskins' has been marked inactive and is no longer for sale")

      within "#item-#{@tire.id}" do
        expect(page).to have_content("Status: inactive")
        expect(page).to_not have_link("Deactivate Item")
      end

      within "#item-#{@stud.id}" do
        expect(page).to have_content("Status: #{@stud.status}")
      end
    end

  describe "If an item is already inactive" do
    it "I see a link to activate the item next to all inactive items" do

      visit "merchant/items"

      within "#item-#{@tire.id}" do
        expect(page).to have_link("Deactivate Item")
        expect(page).to_not have_link("Activate Item")
      end

      within "#item-#{@stud.id}" do
        expect(page).to_not have_link("Deactivate Item")
        expect(page).to have_link("Activate Item")
      end
    end
  end

    describe "when I click the activate button I am redirected back to my items page" do
      it "I also see a flash message saying the item is for sale and it see its status is now active" do

        visit "/merchant/items"

        within "#item-#{@stud.id}" do
          click_link("Activate Item")
        end
        @stud.reload

        expect(current_path).to eq("/merchant/items")
        expect(page).to have_content("'Canti Studs' has been marked active and is now for sale")

        within "#item-#{@stud.id}" do
          expect(page).to have_content("Status: active")
          expect(page).to_not have_link("Activate Item")
        end

        within "#item-#{@tire.id}" do
          expect(page).to have_content("Status: #{@tire.status}")
        end
      end
    end
  end
end
