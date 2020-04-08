require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "who is a default user and visits the log in page" do

  it "has a field to enter my email address and password" do
    user = User.create!(name: "Josh Tukman",
                          address: "756 Main St",
                          city: "Denver",
                          state: "Colorado",
                          zip: "80209",
                          email: "josh.t@gmail.com",
                          password: "secret_password",
                          password_confirmation: "secret_password",
                          role: 0)
    visit '/login'

      fill_in :email, with: "josh.t@gmail.com"
      fill_in :password, with: "secret_password"
      click_button "Submit"
      expect(current_path).to eq("/default/profile")
      within ".success-flash" do
        expect(page).to have_content("You are logged in!")
      end
    end
  end

  describe "who is a merchant user and visits the log in page" do
    it "has a field to enter my email address and password" do
      merchant = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)
      visit '/login'

        fill_in :email, with: "josh.t@gmail.com"
        fill_in :password, with: "secret_password"
        click_button "Submit"
        expect(current_path).to eq("/merchant")
        within ".success-flash" do
          expect(page).to have_content("You are logged in!")
        end
      end
    end

    # describe "who is a admin user and visits the log in page" do
    #   it "has a field to enter my email address and password" do
    #     merchant = User.create!(name: "Josh Tukman",
    #                           address: "756 Main St",
    #                           city: "Denver",
    #                           state: "Colorado",
    #                           zip: "80209",
    #                           email: "josh.t@gmail.com",
    #                           password: "secret_password",
    #                           password_confirmation: "secret_password",
    #                           role: 1)
    #     visit '/login'
    #
    #       fill_in :email, with: "josh.t@gmail.com"
    #       fill_in :password, with: "secret_password"
    #       click_button "Submit"
    #       expect(current_path).to eq("/admin")
    #       within ".success-flash" do
    #         expect(page).to have_content("You are logged in!")
    #       end
    #     end
    #   end
end
