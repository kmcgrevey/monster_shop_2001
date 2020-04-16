require 'rails_helper'

RSpec.describe "As an Admin user", type: :feature do
  describe "when I visit the merchant index page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
      @kitchen_shop = Merchant.create(name: "The Bake Place", address: '117 Cake St.', city: 'Richmond', state: 'VA', zip: 23221, status: 0)

      admin = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80210",
                            email: "josh@example.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it "shows all merchants in the system" do

      visit "/admin/merchants"

      within ".merchant-#{@bike_shop.id}" do
        expect(page).to have_link "Merchant Name: #{@bike_shop.name}", href: "/admin/merchants/#{@bike_shop.id}"
        expect(page).to have_content(@bike_shop.city)
        expect(page).to have_content(@bike_shop.state)
        expect(page).to have_button("Disable")
      end

      within ".merchant-#{@dog_shop.id}" do
        expect(page).to have_link "#{@dog_shop.name}", href: "/admin/merchants/#{@dog_shop.id}"
        expect(page).to have_content("Meg's Dog Shop")
        expect(page).to have_content(@dog_shop.city)
        expect(page).to have_content(@dog_shop.state)
        expect(page).to have_button("Disable")
      end

      within ".merchant-#{@kitchen_shop.id}" do
        expect(page).to have_link "#{@kitchen_shop.name}", href: "/admin/merchants/#{@kitchen_shop.id}"
        expect(page).to have_content("The Bake Place")
        expect(page).to have_content(@kitchen_shop.city)
        expect(page).to have_content(@kitchen_shop.state)
        expect(page).to have_button("Enable")
      end
    end
  end
end
