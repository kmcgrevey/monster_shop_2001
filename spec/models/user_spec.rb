require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password_digest)}

    it {should validate_uniqueness_of(:email)}
  end

  describe "relationships" do
    it {should have_many :orders}
  end

  describe "roles" do
    it "can be created as a default user" do
        josh = User.create!(name: "Josh Tukman",
                              address: "756 Main St",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80209",
                              email: "josh.t@gmail.com",
                              password: "secret_password",
                              password_confirmation: "secret_password")

        expect(josh.role).to eq("default")
        expect(josh.default?).to be_truthy
    end

    it "can be created as a merchant" do
        josh = User.create!(name: "Josh Tukman",
                        address: "756 Main St",
                        city: "Denver",
                        state: "Colorado",
                        zip: "80209",
                        email: "josh.t@gmail.com",
                        password: "secret_password",
                        password_confirmation: "secret_password",
                        role: 1)

        expect(josh.role).to eq("merchant")
        expect(josh.merchant?).to be_truthy
    end

    it "can be created as an admin" do
        josh = User.create!(name: "Josh Tukman",
                        address: "756 Main St",
                        city: "Denver",
                        state: "Colorado",
                        zip: "80209",
                        email: "josh.t@gmail.com",
                        password: "secret_password",
                        password_confirmation: "secret_password",
                        role: 2)

        expect(josh.role).to eq("admin")
        expect(josh.admin?).to be_truthy
    end
  end

  describe "instance methods" do
    it "knows information about itself" do
      josh = User.create!(name: "Josh Tukman",
                      address: "756 Main St",
                      city: "Denver",
                      state: "Colorado",
                      zip: "80209",
                      email: "josh.t@gmail.com",
                      password: "secret_password",
                      password_confirmation: "secret_password",
                      role: 2)

      expect(josh.info).to eq({name: "Josh Tukman",
                               address: "756 Main St",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80209",
                               email: "josh.t@gmail.com",})
    end

    it "users that are admins can see all orders organized by status" do

    mike = User.create!(name: "Mike Hernandez",
                    address: "756 Mike St",
                    city: "Denver",
                    state: "Colorado",
                    zip: "80209",
                    email: "mike@gmail.com",
                    password: "secret_password",
                    password_confirmation: "secret_password",
                    role: 0)

    kevin = User.create!(name: "Kevin McGrevey",
                    address: "756 Kevin St",
                    city: "Denver",
                    state: "Colorado",
                    zip: "80209",
                    email: "kevin@gmail.com",
                    password: "secret_password",
                    password_confirmation: "secret_password",
                    role: 0)

    krista = User.create!(name: "Krista Stadler",
                    address: "756 Krista St",
                    city: "Denver",
                    state: "Colorado",
                    zip: "80209",
                    email: "krista@gmail.com",
                    password: "secret_password",
                    password_confirmation: "secret_password",
                    role: 1)

    josh = User.create!(name: "Josh Tukman",
                    address: "756 Main St",
                    city: "Denver",
                    state: "Colorado",
                    zip: "80209",
                    email: "josh.t@gmail.com",
                    password: "secret_password",
                    password_confirmation: "secret_password",
                    role: 2)

    cory = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    paper = cory.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    pencil = cory.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    order_1 = mike.orders.create(name: mike.name, address: mike.address, city: mike.city, state: mike.state, zip: mike.zip, status: 3)

    ItemOrder.create!(order_id: order_1.id, item_id: tire.id, price: tire.price, quantity: 2)

    order_2 = mike.orders.create(name: kevin.name, address: kevin.address, city: kevin.city, state: kevin.state, zip: kevin.zip)

    ItemOrder.create!(order_id: order_2.id, item_id: paper.id, price: paper.price, quantity: 1)
    ItemOrder.create!(order_id: order_2.id, item_id: pencil.id, price: pencil.price, quantity: 5)

    order_3 = mike.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 1)

    ItemOrder.create!(order_id: order_3.id, item_id: pencil.id, price: pencil.price, quantity: 1)

    expect(josh.admin?).to eq(true)
    expect(josh.all_orders).to eq([order_2, order_3, order_1])

    expect(mike.admin?).to eq(false)
    expect(mike.all_orders).to eq(nil)
    end
  end

end
