Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "welcome#index"

  resources :merchants

  resources :merchants do
    resources :items, only: [:index]
  end

  resources :items, only: [:index, :show, :edit, :update]

  resources :items do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  #login/logout
  delete "/logout", to: "sessions#destroy"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  #cart
  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/:item_id", to: "cart#plus_minus"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/:increment_decrement", to: "cart#increment_decrement"

  #orders
  resources :orders

  get "/register", to: "users#new"
  post "/users", to: "users#create"

  #admin
  namespace :admin do
    get '/', to: "dashboard#index"
    get '/users', to: "users#index"
    get '/users/:id', to: "users#show"
    get '/merchants', to: "merchants#index"
    patch '/merchants/:id', to: "merchants#update"
    get "/merchants/:id", to: "merchants#show"
  end

  #merchant-employee
  namespace :merchant do
    get "/", to: "dashboard#show"
    get "/items", to: "items#index"
    patch "/items/:id", to: "item_status#update"
    put "/items/:id", to: "items#update"
    delete "/items/:id", to: "items#destroy"
    get "/items/:id/edit", to: "items#edit"
    get "/items/new", to: "items#new"
    post "/:merchant_id/items", to: "items#create"
    get "/orders/:order_id", to: "orders#show"
    patch "/orders/:order_id/:item_id", to: "orders#update"
    get "/items/discounts", to: "discounts#index"
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
