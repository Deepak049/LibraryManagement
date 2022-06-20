Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :users
  resources :books
  resources :orders

  post "/signin" => "sessions#create", as: :sessions

end
