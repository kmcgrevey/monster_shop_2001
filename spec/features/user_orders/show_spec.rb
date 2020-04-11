require 'rails_helper'

RSpec.describe "As a registered user", type: :feature do
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

    it "they can visit their profile page and click a link to their orders show page" do
      visit "/profile"
        click_link "My Orders"
        expect(current_path).to eq("/profile/orders")
    end

    # it "they can visit the order show page and see every order and all of each orders details" do
    #
    #   order1 = @user.orders.create!(name: 'Josh', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)
    #   order2 = @user.orders.create!(name: 'Kevin', address: '123 Kevin Ave', city: 'Denver', state: 'CO', zip: 80222)
    #
    #   visit "/profile/orders"
    #
    #   within "#order-#{order1.id}" do
    #   expect(page).to have_link "Order ##{order1.id}", href: "/orders/#{order1.id}"
    #   expect(page).to have_content(order1.created_at.to_date)
    #   expect(page).to have_content(order1.updated_at.to_date)
    #   expect(page).to have_content(order1.current_status)
    #   expect(page).to have_content(order1.items.total_count)
    #   expect(page).to have_content(order1.items.grand_total)
    #   end
    #
    #   within "#order-#{order2.id}" do
    #   expect(page).to have_link "Order ##{order2.id}", href: "/orders/#{order2.id}"
    #   expect(page).to have_content(order2.created_at.to_date)
    #   expect(page).to have_content(order2.updated_at.to_date)
    #   expect(page).to have_content(order2.current_status)
    #   expect(page).to have_content(order2.items.total_count)
    #   expect(page).to have_content(order2.items.grand_total)
    #   end
    # end
  end
