Rails.application.routes.draw do
  resources :friendships
  resources :requests
  resources :user_profiles
  resources :liked_comments
  resources :comments
  resources :liked_posts
  resources :posts
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
