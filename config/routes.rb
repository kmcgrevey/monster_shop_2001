Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "welcome#index"

  resources :merchants

  resources :merchants do
    resources :items, only: [:index, :new, :create, :destroy]
  end

  resources :items, only: [:index, :show, :edit, :update]

  resources :items do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  resources :orders, only: [:new, :create, :index]


  get "/", to: "welcome#index"
  delete "/logout", to: "sessions#destroy"

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

  resources :orders, only: [:new, :create, :show, :destroy]

  get "/register", to: "users#new"
  post "/users", to: "users#create"

  #admin
  namespace :admin do
    get '/dashboard', to: "dashboard#index"
    get '/users', to: "users#index"
    get '/users/:id', to: "users#show"
  end

  namespace :merchant do
    #get "/", to: "dashboard#index"
    get "/", to: "dashboard#show"
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
