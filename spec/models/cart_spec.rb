require 'rails_helper'

describe Cart, type: :model do

  describe 'instance methods' do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pedals = @meg.items.create!(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    end

    it 'add_item(item)' do
      cart = Cart.new({@tire.id.to_s => 1, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      cart.add_item(@pencil.id.to_s)
      expect(cart.contents).to eq({@tire.id.to_s => 1, @pedals.id.to_s => 2, @paper.id.to_s => 1, @pencil.id.to_s => 1})
    end

    it 'total_items' do
      cart = Cart.new({@tire.id.to_s => 1, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      expect(cart.total_items).to eq(4)
    end

    it 'items' do
      cart = Cart.new({@tire.id.to_s => 1, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      expect(cart.items).to eq({@tire => 1, @pedals => 2, @paper => 1})
    end

    it 'subtotal(item)' do
      cart = Cart.new({@tire.id.to_s => 1, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      expect(cart.subtotal(@tire)).to eq(100)
    end

    it 'total' do
      cart = Cart.new({@tire.id.to_s => 1, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      expect(cart.total).to eq(540)
    end

    it 'add_quantity(item_id)' do
      cart = Cart.new({@tire.id.to_s => 1, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      expect(cart.add_quantity(@paper.id.to_s)).to eq(2)
    end

    it 'limit_reached?(item_id)' do
      cart = Cart.new({@tire.id.to_s => 12, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      expect(cart.limit_reached?(@tire.id.to_s)).to eq(true)
      expect(cart.limit_reached?(@pedals.id.to_s)).to eq(false)
    end

    it 'subtract_quantity(item_id)' do
      cart = Cart.new({@tire.id.to_s => 12, @pedals.id.to_s => 2, @paper.id.to_s => 1})
      expect(cart.subtract_quantity(@pedals.id.to_s)).to eq(1)
    end

    it 'quantity_zero?(item_id)' do
      cart = Cart.new({@tire.id.to_s => 12, @pedals.id.to_s => 1, @paper.id.to_s => 1})
      expect(cart.quantity_zero?(@tire.id.to_s)).to eq(false)
      expect(cart.quantity_zero?(@pedals.id.to_s)).to eq(false)
      cart.subtract_quantity(@pedals.id.to_s)
      expect(cart.quantity_zero?(@pedals.id.to_s)).to eq(true)
    end
  end
end
