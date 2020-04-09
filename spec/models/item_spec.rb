require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end

        
    it 'qty_purchased' do
      order = Order.create!(name: 'Josh', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)
      ItemOrder.create!(order_id: order.id, item_id: @chain.id, price: @chain.price, quantity: 4)
      
      expect(@chain.qty_purchased).to eq(4)
    end
  end

  describe "class methods" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @seat = @meg.items.create!(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      @pump = @meg.items.create!(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
      @pedals = @meg.items.create!(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
      @helmet = @meg.items.create!(name: "Helmet", description: "Safety Third!", price: 100, image: "https://www.rei.com/media/product/153004", inventory: 20)
      
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @carrier = @brian.items.create!(name: "Carrier", description: "Home away from home", price: 70, image: "https://s7d2.scene7.com/is/image/PetSmart/5168894?$sclp-prd-main_large$", inventory: 32)
      @bed = @brian.items.create!(name: "Doggie Bed", description: "Soo plush and comfy!", price: 40, image: "https://s7d2.scene7.com/is/image/PetSmart/5291324", inventory: 32)
      @dog_food = @brian.items.create!(name: "Bag o Food", description: "Nutrition in bulk", price: 54, image: "https://s7d2.scene7.com/is/image/PetSmart/5149892", inventory: 32)
      @collar = @brian.items.create!(name: "Dog Collar", description: "Choker", price: 18, image: "https://s7d2.scene7.com/is/image/PetSmart/5169886", inventory: 32)
      @brush = @brian.items.create!(name: "Dog Brush", description: "Detangle those curls", price: 12, image: "https://s7d2.scene7.com/is/image/PetSmart/5280398", inventory: 32)

      @order = Order.create!(name: 'Josh', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)
   
      ItemOrder.create!(order_id: @order.id, item_id: @tire.id, price: @tire.price, quantity: 11)
      ItemOrder.create!(order_id: @order.id, item_id: @seat.id, price: @seat.price, quantity: 10)
      ItemOrder.create!(order_id: @order.id, item_id: @pull_toy.id, price: @pull_toy.price, quantity: 9)
      ItemOrder.create!(order_id: @order.id, item_id: @pump.id, price: @pump.price, quantity: 8)
      ItemOrder.create!(order_id: @order.id, item_id: @pedals.id, price: @pedals.price, quantity: 7)
      
      ItemOrder.create!(order_id: @order.id, item_id: @helmet.id, price: @helmet.price, quantity: 6)
      ItemOrder.create!(order_id: @order.id, item_id: @carrier.id, price: @carrier.price, quantity: 5)
      ItemOrder.create!(order_id: @order.id, item_id: @bed.id, price: @bed.price, quantity: 4)
      ItemOrder.create!(order_id: @order.id, item_id: @dog_food.id, price: @dog_food.price, quantity: 3)
      ItemOrder.create!(order_id: @order.id, item_id: @collar.id, price: @collar.price, quantity: 2)
      ItemOrder.create!(order_id: @order.id, item_id: @brush.id, price: @brush.price, quantity: 1)
    end
    
    it '.most_popular_5' do
       expect(Item.most_popular_5).to eq([@tire, @seat, @pull_toy, @pump, @pedals])
    end
    
    it '.least_popular_5' do
       expect(Item.least_popular_5).to eq([@brush, @collar, @dog_food, @bed, @carrier])
    end
    
  end
end
