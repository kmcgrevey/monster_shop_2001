require 'rails_helper'

RSpec.describe "As a Merchant" do
  describe "When I visit my merchant dashboard" do
    before(:each) do
      @user = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)
    end
    
    xit "I can click a link to view my own items" do
      visit "/merchant"

      click_link "My Items"

      expect(current_path).to eq("/merchant/items")
    end
  end
end