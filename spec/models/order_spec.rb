require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe "status" do
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

    end

    it "can have a status of packaged" do
      order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)

      expect(order_1.packaged?).to eq(true)
    end

    it "can have a status of pending" do
      order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 1)

      expect(order_1.pending?).to eq(true)
    end

    it "can have a status of shipped" do
      order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 2)

      expect(order_1.shipped?).to eq(true)
    end

    it "can have a status of cancelled" do
      order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 3)

      expect(order_1.cancelled?).to eq(true)
    end
  end

  describe 'instance methods' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @user = User.create!(name: "Josh Tukman",
                            address: "756 Main St.",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 0)

      @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
#       this will probably cause problems since status is now an int.  Likely will need to create a new status in enums
#       Mike's code is below, Kristas is not commented out
#       @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
#       @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: "Unfulfilled")
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3, status: "Unfulfilled")

    end

    it 'total_count' do
      expect(@order_1.total_count).to eq(5)
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it 'cancel_order' do
    @order_1.cancel_order

    expect(@order_1.item_orders.first.status).to eq("Unfulfilled")
    expect(@order_1.item_orders.last.status).to eq("Unfulfilled")
    expect(@order_1.status).to eq("Cancelled")
    end

    it 'fulfill_item' do
      @order_1.fulfill_item(@tire)
      expect(@order_1.status).to eq("Pending")

      @order_1.fulfill_item(@pull_toy)
      expect(@order_1.status).to eq("Packaged")
    end
  end

end
