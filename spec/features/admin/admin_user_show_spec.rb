require 'rails_helper'

RSpec.describe "As an Admin user", type: :feature do
  describe "when I visit a user's show page" do
    before(:each) do
      @user = User.create(name: 'Regular User',
                        address: '111 User St',
                        city: 'Norcross',
                        state: 'VA',
                        zip: '23221',
                        email: 'user@example.com',
                        password: 'password_regular',
                        password_confirmation: 'password_regular',
                        role: 0)

      @admin = User.create(name: 'Admin User',
                        address: '123 Street Road',
                        city: 'Smallville',
                        state: 'IA',
                        zip: "12345",
                        email: 'admin@example.com',
                        password: 'password_admin',
                        password_confirmation: 'password_admin',
                        role: 2) 

    end
                      
    it "I see same info that user would see" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      visit "/profile"
      
      within ".user-info" do
        expect(page).to have_content("#{@user.name}")
        expect(page).to have_content("#{@user.address}")
        expect(page).to have_content("#{@user.city}")
        expect(page).to have_content("#{@user.state}")
        expect(page).to have_content("#{@user.zip}")
        expect(page).to have_content("#{@user.email}")
        expect(page).to_not have_content("#{@user.password}")
        expect(page).to have_link("My Orders")
      end
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      
      visit "/admin/users/#{@user.id}"
      
      within ".user-info" do
        expect(page).to have_content("#{@user.name}")
        expect(page).to have_content("#{@user.address}")
        expect(page).to have_content("#{@user.city}")
        expect(page).to have_content("#{@user.state}")
        expect(page).to have_content("#{@user.zip}")
        expect(page).to have_content("#{@user.email}")
        expect(page).to_not have_content("#{@user.password}")
        expect(page).to have_link("My Orders")
      end
    end

    it "I do not see a link to edit their profile or password" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      visit "/profile"
      
      within ".user-info" do
        expect(page).to have_link("Edit Profile")
        expect(page).to have_link("Change Password")
      end
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      
      visit "/admin/users/#{@user.id}"
      
      within ".user-info" do
        expect(page).not_to have_link("Edit Profile")
        expect(page).not_to have_button("Edit Profile")
        expect(page).not_to have_link("Change Password")
        expect(page).not_to have_button("Change Password")
      end
    end

  end
end
