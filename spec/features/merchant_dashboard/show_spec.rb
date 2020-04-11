require 'rails_helper'

RSpec.describe "As a merchant employee", type: :feature do
  describe "when I visit my dashboard show page" do

    it "can show the name and full address of the merchant that I work for" do

      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)

      josh = bike_shop.users.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80210",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)
    visit "/merchant" 

    expect(page).to have_content("Brian's Bike Shop")
    expect(page).to_not have_content("Meg's Dog Shop")
    expect(page).to have_content("Address: #{bike_shop.address}")
    end
  end
end
