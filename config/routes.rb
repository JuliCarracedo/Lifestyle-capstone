Rails.application.routes.draw do
  root to: "users#login"
  resources :votes
  resources :articles
  resources :categories
  resources :users
  get "/login", to: "users#login", as: :user_login
  post "/create_session", to: "users#create_session", as: :create_session
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
