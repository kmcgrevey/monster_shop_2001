require 'rails_helper'

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :description }
    it { should validate_presence_of :discount_amount }
    it { should validate_presence_of :minimum_quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
  end

  describe "instance variables" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @seat = @meg.items.create!(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      @pedals = @meg.items.create!(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
      @stud = @meg.items.create(name: "Canti Studs", description: "You don't need 'em till you do.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)

      @discount_1 = @tire.discounts.create(description: "25% off 4 or More", discount_amount: 0.25, minimum_quantity: 4)
      @discount_2 = @pedals.discounts.create(description: "10% off 2 or More", discount_amount: 0.10, minimum_quantity: 2)
    end

    it 'adjusted_item_price' do
      expect(@discount_1.adjusted_item_price).to eq(75)
      expect(@discount_2.adjusted_item_price).to eq(189)
    end

    it 'discounted_subtotal' do
      @cart = Cart.new({@tire.id.to_s => 4, @pedals.id.to_s => 2})

      expect(@discount_1.discounted_subtotal(@cart)).to eq(300)
      expect(@discount_2.discounted_subtotal(@cart)).to eq(378)
    end
  end
end
