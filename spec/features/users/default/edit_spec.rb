require 'rails_helper'

RSpec.describe "As a registered default user" do
  describe "when I visit my profile page" do
    before(:each) do
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
      end
      it "lets me click on a link to edit my profile data" do

      visit "/profile"
      click_link "Edit Profile"
      expect(current_path).to eq("/profile/#{@user.id}/edit")
      end
      it "can allow editing a form that is prepopulated with current info except password to edit and displays updated info" do
        visit "/profile/#{@user.id}/edit"
        expect(find_field(:name).value).to eq "Josh Tukman"
        expect(find_field(:address).value).to eq "756 Main St."
        expect(find_field(:city).value).to eq "Denver"
        expect(find_field(:state).value).to eq "Colorado"
        expect(find_field(:zip).value).to eq "80209"
        expect(find_field(:email).value).to eq "josh.t@gmail.com"


        fill_in :address, with: "2223 Bellflower Dr."
        fill_in :city, with: "Broomfield"
        click_button "Submit"
        expect(current_path).to eq("/profile")
        within ".success-flash" do
          expect(page).to have_content("Your information has been updated!")
        end
        expect(page).to have_content("Josh Tukman")
        expect(page).to have_content("2223 Bellflower Dr.")
        expect(page).to have_content("Broomfield")
        expect(page).to have_content("Colorado")
        expect(page).to have_content("80209")
        expect(page).to have_content("josh.t@gmail.com")
      end
  end

end


# When I click on the link to edit my profile data
# I see a form like the registration page
# The form is prepopulated with all my current information except my password
# When I change any or all of that information
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information
