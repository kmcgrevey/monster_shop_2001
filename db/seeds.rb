# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Merchant.destroy_all
Item.destroy_all
Order.destroy_all
ItemOrder.destroy_all


#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
kitchen_shop = Merchant.create(name: "The Bake Place", address: '117 Cake St.', city: 'Richmond', state: 'VA', zip: 23221)

#users
admin = User.create(name: 'Admin',
                    address: '123 Street Road',
                    city: 'Smallville',
                    state: 'IA',
                    zip: "12345",
                    email: 'admin@example.com',
                    password: 'password_admin',
                    password_confirmation: 'password_admin',
                    role: 2)

merchant = bike_shop.users.create(name: 'Merchant1',
                       address: '456 Main St',
                       city: 'Townsburg',
                       state: 'CA',
                       zip: "98765",
                       email: 'merchant@example.com',
                       password: 'password_merchant',
                       password_confirmation: 'password_merchant',
                       role: 1)

merchant1 = User.create(name: 'Merchant1',
                        address: '456 Main St',
                        city: 'Townsburg',
                        state: 'CA',
                        zip: "98765",
                        email: 'merchant1@example.com',
                        password: 'merchant1',
                        password_confirmation: 'merchant1',
                        role: 1)

josh = User.create(name: 'Josh Tukman',
                   address: '78 Josh Ave',
                   city: 'Denver',
                   state: 'CO',
                   zip: "80210",
                   email: 'josh@example.com',
                   password: 'josh',
                   password_confirmation: 'josh',
                   role: 0)

kevin = User.create(name: 'Kevin McGrevey',
                   address: '79 Kevin Ave',
                   city: 'Denver',
                   state: 'CO',
                   zip: "80210",
                   email: 'kevin@example.com',
                   password: 'kevin',
                   password_confirmation: 'kevin',
                   role: 0)

krista = User.create(name: 'Krista Stadler',
                     address: '29 Krista St',
                     city: 'Panama City Beach',
                     state: 'FL',
                     zip: '32407',
                     email: 'krista@example.com',
                     password: 'krista',
                     password_confirmation: 'krista',
                     role: 0)

mike = User.create(name: 'Mike Hernandez',
                    address: '111 Mike St',
                    city: 'Richmond',
                    state: 'VA',
                    zip: '23221',
                    email: 'mike@example.com',
                    password: 'mike',
                    password_confirmation: 'mike',
                    role: 0)

user = User.create(name: 'Mike Hernandez',
                  address: '111 Mike St',
                  city: 'Richmond',
                  state: 'VA',
                  zip: '23221',
                  email: 'user@example.com',
                  password: 'password_regular',
                  password_confirmation: 'password_regular',
                  role: 0)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
seat = bike_shop.items.create(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
pump = bike_shop.items.create(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
pedals = bike_shop.items.create(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
helmet = bike_shop.items.create(name: "Helmet", description: "Safety Third!", price: 100, image: "https://www.rei.com/media/product/153004", inventory: 20)
stud = bike_shop.items.create(name: "Canti Studs", description: "You don't need 'em till you do.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
carrier = dog_shop.items.create(name: "Carrier", description: "Home away from home", price: 70, image: "https://s7d2.scene7.com/is/image/PetSmart/5168894?$sclp-prd-main_large$", inventory: 32)
bed = dog_shop.items.create(name: "Doggie Bed", description: "Soo plush and comfy!", price: 40, image: "https://s7d2.scene7.com/is/image/PetSmart/5291324", inventory: 32)
dog_food = dog_shop.items.create(name: "Bag o Food", description: "Nutrition in bulk", price: 54, image: "https://s7d2.scene7.com/is/image/PetSmart/5149892", inventory: 32)
collar = dog_shop.items.create(name: "Dog Collar", description: "Choker", price: 18, image: "https://s7d2.scene7.com/is/image/PetSmart/5169886", inventory: 32)
brush = dog_shop.items.create(name: "Dog Brush", description: "Detangle those curls", price: 12, image: "https://s7d2.scene7.com/is/image/PetSmart/5280398", inventory: 32)


#kitchen_shop items
knife = kitchen_shop.items.create(name: "Knife", description: "You call that a knife? This is a knife!", price: 75, image: "https://www.surlatable.com/dw/image/v2/BCJL_PRD/on/demandware.static/-/Sites-shop-slt-master-catalog/default/dwc69b71c7/images/large/13603_s2.jpg")
pot = kitchen_shop.items.create(name: "Cooking Pot", description: "Legality varies by state", price: 120, image: "https://www.surlatable.com/dw/image/v2/BCJL_PRD/on/demandware.static/-/Sites-shop-slt-master-catalog/default/dw3ea530cd/images/large/5113030_01i_0219_s.jpg")
espresso = kitchen_shop.items.create(name: "Breville Bambino Plus", description: "Impress your friends!", price: 500, image: "https://www.surlatable.com/dw/image/v2/BCJL_PRD/on/demandware.static/-/Sites-shop-slt-master-catalog/default/dw92544ea3/images/large/4910287_1118_vs.jpg")
corn_holder = kitchen_shop.items.create(name: "OXO Corn Holders", description: "Good for corny jokes", price: 500, image: "https://www.surlatable.com/dw/image/v2/BCJL_PRD/on/demandware.static/-/Sites-shop-slt-master-catalog/default/dw66439aea/images/large/1473222_01i_0414_s.jpg")


#users
admin = User.create(name: 'Admin',
                    address: '123 Street Road',
                    city: 'Smallville',
                    state: 'IA',
                    zip: "12345",
                    email: 'admin@example.com',
                    password: 'admin',
                    password_confirmation: 'admin',
                    role: 2)
merchant1 = bike_shop.users.create(name: 'Merchant1',
                        address: '456 Main St',
                        city: 'Townsburg',
                        state: 'CA',
                        zip: "98765",
                        email: 'merchant1@example.com',
                        password: 'merchant1',
                        password_confirmation: 'merchant1',
                        role: 1)
merchant2 = dog_shop.users.create(name: 'Merchant2',
                        address: '789 Main St',
                        city: 'Cityville',
                        state: 'OH',
                        zip: "44004",
                        email: 'merchant2@example.com',
                        password: 'merchant2',
                        password_confirmation: 'merchant2',
                        role: 1)
user = User.create(name: 'User',
                   address: '78 Broadway Ave',
                   city: 'Denver',
                   state: 'CO',
                   zip: "80210",
                   email: 'user@example.com',
                   password: 'user',
                   password_confirmation: 'user',
                   role: 0)
josh = bike_shop.users.create!(name: "Josh Tukman",
                               address: "756 Main St",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80210",
                               email: "josh.t@gmail.com",
                               password: "secret_password",
                               password_confirmation: "secret_password",
                               role: 1)

#orders
order1 = josh.orders.create!(name: 'Josh Tukman', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345, status: 1)
order2 = kevin.orders.create!(name: 'Kevin McGrevey', address: '123 Kevin Ave', city: 'Denver', state: 'CO', zip: 80222)

#add items to order #FOREIGN KEY VIOLATION ERROR???
ItemOrder.create!(order_id: order2.id, item_id: tire.id, price: tire.price, quantity: 9)
ItemOrder.create!(order_id: order2.id, item_id: carrier.id, price: carrier.price, quantity: 2)

ItemOrder.create!(order_id: order1.id, item_id: tire.id, price: tire.price, quantity: 2)
ItemOrder.create!(order_id: order1.id, item_id: seat.id, price: seat.price, quantity: 10)
ItemOrder.create!(order_id: order1.id, item_id: pull_toy.id, price: pull_toy.price, quantity: 9)
ItemOrder.create!(order_id: order1.id, item_id: pump.id, price: pump.price, quantity: 8)
ItemOrder.create!(order_id: order1.id, item_id: pedals.id, price: pedals.price, quantity: 7)

ItemOrder.create!(order_id: order1.id, item_id: helmet.id, price: helmet.price, quantity: 6)
ItemOrder.create!(order_id: order1.id, item_id: carrier.id, price: carrier.price, quantity: 3)
ItemOrder.create!(order_id: order1.id, item_id: bed.id, price: bed.price, quantity: 4)
ItemOrder.create!(order_id: order1.id, item_id: dog_food.id, price: dog_food.price, quantity: 3)
ItemOrder.create!(order_id: order1.id, item_id: collar.id, price: collar.price, quantity: 2)
ItemOrder.create!(order_id: order1.id, item_id: brush.id, price: brush.price, quantity: 1)
