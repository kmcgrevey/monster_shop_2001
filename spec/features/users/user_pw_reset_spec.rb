require 'rails_helper'

RSpec.describe "when I visit my profile page" do

  before(:each) do
  @user = User.create!(name: "Josh Tukman",
                       address: "756 Main St",
                       city: "Denver",
                       state: "Colorado",
                       zip: "80209",
                       email: "josh.t@gmail.com",
                       password: "secret_password",
                       password_confirmation: "secret_password",
                       role: 0)

  end

  it "I see a link to change my password" do
    visit '/login'

    fill_in :email, with: "josh.t@gmail.com"
    fill_in :password, with: "secret_password"
    click_button "Submit"

    within ".pw-change-button" do
      expect(page).to have_link("Change Password")
    end
  end

  describe "when I click the change password link I am taken to a form where I can change it" do
    describe "when i click submit I am taken to my profile page" do
      it "when I enter a pw and confirmation and click submit I see a flash confirmation" do
        visit '/login'

        fill_in :email, with: "josh.t@gmail.com"
        fill_in :password, with: "secret_password"
        click_button "Submit"

        click_link("Change Password")
        expect(current_path).to eq("/profile/password/edit")

        fill_in :password, with: "new_password"
        fill_in :password_confirmation, with: "new_password"

        click_button("Submit")

        expect(current_path).to eq("/profile")
      end
    end
  end
end
