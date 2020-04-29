Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get "/", to: "welcome#index" # <-- ORIGINAL
  root "welcome#index"

  # resources :merchants # <-- ORIGINAL
  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id", to: "merchants#show"
  delete "/merchants/:id", to: "merchants#destroy"

  # resources :merchants do # <-- ORIGINAL 14-16
  #   resources :items, only: [:index]
  # end
  get "/merchants/:merchant_id/items", to: "items#index"

  # resources :items, only: [:index, :show] do # <-- ORIGINAL 19-21
  #   resources :reviews, only: [:new, :create]
  # end
  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  
  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"
  # resources :reviews, only: [:edit, :update, :destroy] # <-- ORIGINAL
  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  #login/logout
  delete "/logout", to: "sessions#destroy"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  #cart
  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/:increment_decrement", to: "cart#increment_decrement"

  #orders
  # resources :orders # <-- ORIGINAL
  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  patch "/orders/:id", to: "orders#update"
  delete "/orders/:id", to: "orders#destroy"

  get "/register", to: "users#new"
  post "/users", to: "users#create"

  #admin
  namespace :admin do
    get '/', to: "dashboard#index"
    resources :users, only: [:index, :show]
    resources :merchants, only: [:index, :update, :show]
    # get '/users', to: "users#index"
    # get '/users/:id', to: "users#show"
    # get '/merchants', to: "merchants#index"
    # patch '/merchants/:id', to: "merchants#update"
    # get "/merchants/:id", to: "merchants#show"
  end

  #merchant-employee
  namespace :merchant do
    get "/", to: "dashboard#show"
    resources :items, only: [:index, :edit, :new, :destroy]
    # get "/items", to: "items#index"
    put "/items/:id", to: "items#update" # <-- ODD ROUTE WON'T RESOURCE
    # delete "/items/:id", to: "items#destroy"
    # get "/items/:id/edit", to: "items#edit"
    # get "/items/new", to: "items#new"
    post "/:merchant_id/items", to: "items#create" # <-- ODD ROUTE WON'T RESOURCE
    patch "/items/:id", to: "item_status#update"
    get "/orders/:order_id", to: "orders#show"
    patch "/orders/:order_id/:item_id", to: "orders#update"
  end

  namespace :profile do
    get "/", to: "profile#show"
    get "/password/edit", to: "passwords#edit"
    patch "/password/edit", to: "passwords#update"
    get "/:id/edit", to: "profile#edit"
    patch "/:id", to: "profile#update"
    get "/orders", to: "orders#index"
    get "/orders/:order_id", to: "orders#show"
  end

end
