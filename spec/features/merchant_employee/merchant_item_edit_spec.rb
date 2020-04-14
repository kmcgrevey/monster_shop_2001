require 'rails_helper'

RSpec.describe "as a merchant employee when I visit my items page", type: :feature do
  # As a merchant employee
  # When I visit my items page
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

  describe "when I click the edit button next to any item" do
    # And I click the edit button or link next to any item
    it "I am taken to a pre-populated form with all of the item's information" do
      # Then I am taken to a form similar to the 'new item' form
      # The form is pre-populated with all of this item's information
      visit "/merchant/items"

      within "#item-#{@tire.id}" do
        expect(page).to have_content("#{@tire.name}")
        expect(page).to have_link("Edit Item")
      end

      within "#item-#{@stud.id}" do
        expect(page).to have_content("#{@stud.name}")
        click_link("Edit Item")
      end

      expect(current_path).to eq("/merchant/items/#{@stud.id}/edit")

      expect(find_field("Name").value).to eq("#{@stud.name}")
      expect(find_field("Description").value).to eq("#{@stud.description}")
      expect(find_field("Price").value).to eq("#{@stud.price}")
      expect(find_field("Image").value).to eq("#{@stud.image}")
      expect(find_field("Inventory").value).to eq("#{@stud.inventory}")
      expect(page).to have_button("Update Item")
    end

    describe "I can change the information but all the rules for new items still apply" do

      it "has to have a name" do
        visit "/merchant/items/#{@stud.id}/edit"

        fill_in "Name", with: ""

        click_button("Update Item")

        expect(current_path).to eq("/merchant/items/#{@stud.id}/edit")
        expect(page).to have_content("Name can't be blank")
      end

      it "has to have a description" do
        visit "/merchant/items/#{@stud.id}/edit"

        fill_in "Description", with: ""

        click_button("Update Item")

        expect(current_path).to eq("/merchant/items/#{@stud.id}/edit")
        expect(page).to have_content("Description can't be blank")
      end

      it "can't have a negative price " do
        visit "/merchant/items/#{@stud.id}/edit"

        fill_in "Price", with: "-5"

        click_button("Update Item")

        expect(current_path).to eq("/merchant/items/#{@stud.id}/edit")
        expect(page).to have_content("Price must be greater than 0")
      end

      it "can't have a negative inventory" do
        visit "/merchant/items/#{@stud.id}/edit"
        fill_in "Inventory", with: "-5"

        click_button("Update Item")

        expect(current_path).to eq("/merchant/items/#{@stud.id}/edit")
        expect(page).to have_content("Inventory must be greater than 0")
      end
    end

    describe "it can update things if it gets real information" do
      it "and it will give a flash message for success and redirect to /merchant/items" do
        visit "/merchant/items/#{@stud.id}/edit"

        fill_in "Name", with: "Canti Boss"

        click_button("Update Item")

        expect(current_path).to eq("/merchant/items")
        expect(page).to have_content("Item information has been updated!")

        within "#item-#{@stud.id}" do
          expect(page).to_not have_content("Canti Studs")
          expect(page).to have_content("Canti Boss")
          expect(page).to have_content("#{@stud.description}")
          expect(page).to have_content("#{@stud.price}")
          expect(page).to have_css("img[src*='#{@stud.image}']")
          expect(page).to have_content("#{@stud.inventory}")
          expect(page).to have_content("Status: inactive")
        end
      end

  end
  #
  #   it "if I don't supply an image, a default thumbnail is in its place" do
  #     # If I left the image field blank, I see a placeholder image for the thumbnail
  #
  #   end
  # end
end
end
