require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
    describe 'and visit my cart path' do
      before(:each) do
        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @pedals = @meg.items.create!(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
        @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
        @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        visit "/items/#{@paper.id}"
        click_on "Add To Cart"
        visit "/items/#{@tire.id}"
        click_on "Add To Cart"
        visit "/items/#{@pedals.id}"
        click_on "Add To Cart"
        visit "/items/#{@pencil.id}"
        click_on "Add To Cart"
        @items_in_cart = [@paper,@tire,@pedals,@pencil]
      end

      it 'I can empty my cart by clicking a link' do
        visit '/cart'
        expect(page).to have_link("Empty Cart")
        click_on "Empty Cart"
        expect(current_path).to eq("/cart")
        expect(page).to_not have_css(".cart-items")
        expect(page).to have_content("Cart is currently empty")
      end

      it 'I see all items Ive added to my cart' do
        visit '/cart'

        @items_in_cart.each do |item|
          within "#cart-item-#{item.id}" do
            expect(page).to have_link(item.name)
            expect(page).to have_css("img[src*='#{item.image}']")
            expect(page).to have_link("#{item.merchant.name}")
            expect(page).to have_content("$#{item.price}")
            expect(page).to have_content("1")
            expect(page).to have_content("$#{item.price}")
          end
        end
        expect(page).to have_content("Total: $122")

        visit "/items/#{@pencil.id}"
        click_on "Add To Cart"

        visit '/cart'

        within "#cart-item-#{@pencil.id}" do
          expect(page).to have_content("2")
          expect(page).to have_content("$4")
        end

        expect(page).to have_content("Total: $124")
      end

      it "I see a button next to each item to add and subtract the quantity of each item" do
       visit '/cart'

        within "#cart-item-#{@pencil.id}" do
          expect(page).to have_button("Add Qty")
          expect(page).to have_button("Subtract Qty")
        end

        within "#cart-item-#{@paper.id}" do
          expect(page).to have_button("Add Qty")
          expect(page).to have_button("Subtract Qty")
        end

        within "#cart-item-#{@tire.id}" do
          expect(page).to have_button("Add Qty")
          expect(page).to have_button("Subtract Qty")
        end

      end

      it "I click the add button to increase quantity but cannot exceed that items inventory limit" do
        visit '/cart'

        within "#cart-item-#{@tire.id}" do
          expect(page).to have_content("1")
          click_button "Add Qty"
          expect(page).to have_content("2")
        end

        within "#cart-item-#{@tire.id}" do
          13.times do
            click_button "Add Qty"
          end
          expect(page).to have_content("12")
        end
      end

      it "I click the subtract button until zero to remove item from my cart" do
        visit '/cart'

        within "#cart-item-#{@tire.id}" do
          click_button "Add Qty"
        end

        within "#cart-item-#{@tire.id}" do
          expect(page).to have_content("2")
        end

        within "#cart-item-#{@tire.id}" do
          click_button "Subtract Qty"
        end

        within "#cart-item-#{@tire.id}" do
          expect(page).to have_content("1")
        end

        expect(page).to have_link(@tire.name)

        within "#cart-item-#{@tire.id}" do
          click_button "Subtract Qty"
        end

        expect(page).not_to have_link(@tire.name)
      end

      it "When the quantity of a specific item meets the discount threshold, a discount is automatically applied to that item" do
        @discount_1 = @tire.discounts.create(description: "25% off 4 or More", discount_amount: 0.25, minimum_quantity: 4)
        @discount_2 = @pedals.discounts.create(description: "10% off 2 or More", discount_amount: 0.10, minimum_quantity: 2)

        within "#cart-item-#{@tire.id}" do
          3.times do
            click_button "Add Qty"
          end
          expect(page).to have_content "25% off 4 or More discount added"
          expect(page).to have_content "$75"
        end

        within "#cart-item-#{@tire.id}" do
          click_button "Add Qty"
          expect(page).to have_content "10% off 2 or More discount added"
          expect(page).to have_content "$189"
        end
        
      end
    end
  end

  describe "When I haven't added anything to my cart" do
    describe "and visit my cart show page" do
      it "I see a message saying my cart is empty" do
        visit '/cart'
        expect(page).to_not have_css(".cart-items")
        expect(page).to have_content("Cart is currently empty")
      end

      it "I do NOT see the link to empty my cart" do
        visit '/cart'
        expect(page).to_not have_link("Empty Cart")
      end

    end
  end
end
