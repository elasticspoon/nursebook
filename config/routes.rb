Rails.application.routes.draw do
  resources :notifications
  resources :friendships
  resources :requests
  resources :user_profiles
  resources :liked_comments
  resources :comments
  put '/liked_posts/:id', to: 'liked_posts#create'
  resources :liked_posts, only: %i[show create destroy]
  resources :posts
  root 'posts#index'
  devise_for :users
  get 'not_implemented', to: 'application#not_implemented'
  post 'not_implemented', to: 'application#not_implemented'
  put 'not_implemented', to: 'application#not_implemented'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
