Rails.application.routes.draw do
  get 'categorization/create/:article_id/:category_id', to: "categorization#create", as: :create_categorization
  delete 'categorization/destroy/:article_id/:category_id', to: "categorization#destroy", as: :destroy_categorization
  root to: "articles#index"
  resources :articles
  resources :categories
  resources :users
  
  get "/login", to: "users#login", as: :user_login
  post "/create_session", to: "users#create_session", as: :create_session
  delete "/kill_session", to: "users#kill_session", as: :kill_session

  post "/votes/create/:user_id/:article_id", to: "votes#create", as: :create_vote
  delete "/vote/:user_id/:article_id", to: "votes#destroy", as: :destroy_vote
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
