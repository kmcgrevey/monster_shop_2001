Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "welcome#index"
  delete "/logout", to: "sessions#destroy"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  resources :merchants

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  resources :orders, only: [:new, :create, :show]

  get "/register", to: "users#new"
  post "/users", to: "users#create"

  #admin
  namespace :admin do
    get '/dashboard', to: "dashboard#index"
    get '/users', to: "users#index"
  end

  namespace :merchant do
    get "/", to: "dashboard#index"
  end

  namespace :profile do
    get "/", to: "profile#show"
    get "/password/edit", to: "passwords#edit"

  end

end
