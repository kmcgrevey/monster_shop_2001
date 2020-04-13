require 'rails_helper'

RSpec.describe "When I visit the admin's merchant index page ('/admin/merchants')", type: :feature do

  before(:each) do

    @today = Time.new(2020,04,11)
    allow(Time).to receive(:now).and_return(@today)

    @josh = User.create!(name: "Josh Tukman",
                         address: "756 Main St",
                         city: "Denver",
                         state: "Colorado",
                         zip: "80209",
                         email: "josh.t@gmail.com",
                         password: "secret_password",
                         password_confirmation: "secret_password",
                         role: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)

    @adam = User.create!(name: "Adam Jackson",
                         address: "1215 Jackson St.",
                         city: "Denver",
                         state: "Colorado",
                         zip: "80222",
                         email: "adamfixesthings@gmail.com",
                         password: "toolman",
                         password_confirmation: "toolman",
                         role: 0)

    @mary = User.create!(name: "Mary Stanley",
                         address: "333 E Wonderview Ave",
                         city: "Estes Park",
                         state: "Colorado",
                         zip: "80517",
                         email: "mary@stanley.com",
                         password: "haunted_password",
                         password_confirmation: "haunted_password",
                         role: 0)

    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203, status: 0)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @seat = @meg.items.create(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
    @pump = @meg.items.create(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)

    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @studs = @mike.items.create(name: "Studs", description: "Inactive status for our test.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)
    
    @order_1 = @adam.orders.create(name: @adam.name, address: @adam.address, city: @adam.city, state: @adam.state, zip: @adam.zip)
    @order_3 = @adam.orders.create(name: @adam.name, address: @adam.address, city: @adam.city, state: @adam.state, zip: @adam.zip, status: 3)
    @order_4 = @adam.orders.create(name: @adam.name, address: @adam.address, city: @adam.city, state: @adam.state, zip: @adam.zip, status: 1)
    @order_5 = @adam.orders.create(name: @adam.name, address: @adam.address, city: @adam.city, state: @adam.state, zip: @adam.zip, status: 2)

    ItemOrder.create!(order_id: @order_1.id, item_id: @tire.id, price: @tire.price, quantity: 2)
    ItemOrder.create!(order_id: @order_3.id, item_id: @tire.id, price: @tire.price, quantity: 3)
    ItemOrder.create!(order_id: @order_4.id, item_id: @pencil.id, price: @pencil.price, quantity: 20)
    ItemOrder.create!(order_id: @order_5.id, item_id: @pencil.id, price: @pencil.price, quantity: 5)

    @order_2 = @mary.orders.create(name: @mary.name, address: @mary.address, city: @mary.city, state: @mary.state, zip: @adam.zip)

    ItemOrder.create!(order_id: @order_2.id, item_id: @paper.id, price: @paper.price, quantity: 1)
    ItemOrder.create!(order_id: @order_2.id, item_id: @pencil.id, price: @pencil.price, quantity: 5)

  end

  it "I see a 'disable' button next to any merchants who are not yet disabled" do
    
    visit "/admin/merchants"
    
    expect(page).to have_content("All Merchants")

    expect(@mike.status).to eq("disabled")
    expect(@meg.status).to eq("enabled")

    within ".merchant-#{@mike.id}" do
      expect(page).to have_content("Merchant Name: #{@mike.name}")
      expect(page).to have_content("Status: disabled")
      expect(page).to_not have_button("Disable")
    end

    within ".merchant-#{@meg.id}" do
      expect(page).to have_content("Merchant Name: #{@meg.name}")
      expect(page).to have_content("Status: enabled")
      click_button("Disable")
    end

    @meg.reload

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Merchant account has been disabled.")

    expect(@meg.status).to eq("disabled")

    within ".merchant-#{@meg.id}" do
      expect(page).to have_content("Merchant Name: #{@meg.name}")
      expect(page).to have_content("Status: disabled")
      expect(page).to_not have_button("Disable")
    end
  end

  it "I click 'enable' button next to any merchants with disabled accounts to enable them" do
    visit "/admin/merchants"

    within ".merchant-#{@mike.id}" do
      expect(page).to have_content("Merchant Name: #{@mike.name}")
      expect(page).to have_content("Status: disabled")
      expect(page).to_not have_button("Disable")
      
      click_button "Enable"
    end

    expect(current_path).to eq("/admin/merchants")
    
    expect(page).to have_content("Merchant account has been enabled.")

    within ".merchant-#{@mike.id}" do
      expect(page).to have_content("Merchant Name: #{@mike.name}")
      expect(page).to have_content("Status: enabled")
      expect(page).to_not have_button("Enable")
    end
  end

  it "clicking 'enable' on a disabled merchant activates all its items" do
    inact_pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", active?:false, inventory: 100)
    
    expect(@mike.status).to eq ("disabled")
    expect(@mike.items).to eq ([@paper, @pencil, @studs, inact_pencil])
    expect(@paper.active?).to eq(true)
    expect(@pencil.active?).to eq(true)
    expect(@studs.active?).to eq(false)
    expect(inact_pencil.active?).to eq(false)

    visit "/admin/merchants"

    within ".merchant-#{@mike.id}" do
      click_button("Enable")
    end
    
    @mike.reload
    @paper.reload
    @pencil.reload
    @studs.reload
    inact_pencil.reload

    expect(@mike.status).to eq ("enabled")
    expect(@mike.items).to eq ([@paper, @pencil, @studs, inact_pencil])
    expect(@paper.active?).to eq(true)
    expect(@pencil.active?).to eq(true)
    expect(@studs.active?).to eq(true)
    expect(inact_pencil.active?).to eq(true)
  end
  
  # MY ORIGINAL TEST THAT LOOKS AT THE MERCHANT ITEMS PAGE 
  # - NOT AVAILABLE ON THE CURRENT BRANCH I AM ON
  # it "clicking 'enable' on a disabled merchant activates all its items" do 
    #   inact_pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", active?:false, inventory: 100)
      
    #   visit "merchants/#{@mike.id}/items"

    #   within "#item-#{@studs.id}" do
    #     expect(page).to have_content(@studs.name)
    #     expect(page).to have_content("Inactive")
    #   end
    #   within "#item-#{inact_pencil.id}" do
    #     expect(page).to have_content(inact_pencil.name)
    #     expect(page).to have_content("Inactive")
    #   end

    #   visit "/admin/merchants"

    #   within ".merchant-#{@mike.id}" do
    #     click_button "Enable"
    #   end
      
    #   visit "merchants/#{@mike.id}/items"

    #   within "#item-#{@studs.id}" do
    #     expect(page).to have_content(@studs.name)
    #     expect(page).to have_content("Active")
    #   end
    #   within "#item-#{inact_pencil.id}" do
    #     expect(page).to have_content(inact_pencil.name)
    #     expect(page).to have_content("Active")
    #   end

    # end

  it "when a merchant is disabled all of their items are also disabled" do
    expect(@meg.status).to eq ("enabled")
    expect(@meg.items).to eq ([@tire, @seat, @pump])
    expect(@tire.active?).to eq(true)
    expect(@seat.active?).to eq(true)
    expect(@pump.active?).to eq(true)

    visit "/admin/merchants"

    within ".merchant-#{@meg.id}" do
      click_button("Disable")
    end
    @meg.reload
    @tire.reload
    @seat.reload
    @pump.reload
    expect(@meg.status).to eq ("disabled")
    expect(@meg.items).to eq ([@tire, @seat, @pump])
    expect(@tire.active?).to eq(false)
    expect(@seat.active?).to eq(false)
    expect(@pump.active?).to eq(false)
  end

end