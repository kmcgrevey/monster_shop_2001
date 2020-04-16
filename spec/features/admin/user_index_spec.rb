require 'rails_helper'

RSpec.describe "As an Admin user", type: :feature do
  describe "when I visit the user index page" do
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

      @user = User.create(name: 'Regular User',
                        address: '111 User St',
                        city: 'Norcross',
                        state: 'VA',
                        zip: '23221',
                        email: 'user@example.com',
                        password: 'password_regular',
                        password_confirmation: 'password_regular',
                        role: 1)

      @josh = User.create!(name: 'Josh Tukman',
                         address: '78 Josh Ave',
                         city: 'Denver',
                         state: 'CO',
                         zip: "80210",
                         email: 'jt@example.com',
                         password: 'josh',
                         password_confirmation: 'josh',
                         role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    it "can show all registered users with link to their show page" do
    visit "/"
    within ".topnav" do
      click_link "All Users"
    end

    expect(current_path).to eq("/admin/users")
    expect(page).to have_link("#{@user.name}", href: "/admin/users/#{@user.id}")
    expect(page).to have_link("#{@josh.name}", href: "/admin/users/#{@josh.id}")
    expect(page).to have_content("#{@user.name} registered on #{@user.created_at.to_date} as a #{@user.role.upcase} user")
    expect(page).to have_content("#{@josh.name} registered on #{@josh.created_at.to_date} as a #{@josh.role.upcase} user")
    end
  end
end
