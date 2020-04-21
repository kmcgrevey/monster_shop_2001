# Monster Shop Group Project

The Monster Shop project is an interactive shopping website that allows a users to do different things, depending on their roles:
* Default Users can view and order items. Once items have been ordered, they can view those orders and their statuses and/or cancel orders, depending on each order's status.
* Merchant Employee Users can view and update inventory for their shop and manage orders for their items.
* Admin Users can view and manage default users, merchant employee users, and all items and orders.

## How to Clone Project to Local Machine
Use the instructions below in combination with your terminal in order to learn more about this project:

  1. Clone this repository:
    ```git@github.com:kmcgrevey/monster_shop_2001.git```

  2. Install the necessary gems:
    ```bundle install``` &
    ```bundle update```

  3. Initialize the database:
    ```rails db:{create,migrate,seed}```

  4. Make a connection with the Rails server:
    ```rails s```

  5. Visit your browser, and enter the following into the search bar:
  ```localhost:3000```

  6. Enjoy!

## Skills Gained from this Project

### Rails
* Create routes for namespaced routes
* Implement partials to break a page into reusable components
* Use Sessions to store information about a user and implement login/logout functionality
* Use filters (e.g. `before_action`) in a Rails controller
* Limit functionality to authorized users
* Use BCrypt to hash user passwords before storing in the database

### ActiveRecord
* Use built-in ActiveRecord methods to join multiple tables of data, calculate statistics and build collections of data grouped by one or more attributes

### Databases
* Design and diagram a Database Schema
* Write raw SQL queries (as a debugging tool for AR)

### Testing and Debugging
* Write feature tests utilizing:
  - RSpec and Capybara
  - CSS selectors to target specific areas of a page
  - Use Pry in Rails files to get more information about an error
  - Use `save_and_open_page` to view the HTML generated when visiting a path in a feature test
  - Utilize the Rails console as a tool to get more information about the current state of a development database
  - Use `rails routes` to get additional information about the routes that exist in a Rails application

## Link to Application in Production
* https://jkkm-monster-shop.herokuapp.com/

## Links to Contributor Github Profiles
* Josh Tukman: https://github.com/Joshua-Tukman
* Kevin McGrevey: https://github.com/kmcgrevey
* Krista Stadler:  https://github.com/kristastadler
* Mike Hernandez: https://github.com/mikez321
