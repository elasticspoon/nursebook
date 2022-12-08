Rails.application.routes.draw do
  resources :notifications
  resources :friendships
  resources :requests
  resources :user_profiles
  resources :comments
  delete 'posts/:id/delete_image/:image_id', to: 'posts#purge_attached_image', as: 'delete_image'
  put '/likes/:id', to: 'likes#create'
  get '/likes(/:id)', to: 'likes#show', as: 'like'
  get '/:target_type/:target_id/index_likers', to: 'likes#index_likers', as: 'index_likers'
  get '/post/:id/index_commentors', to: 'posts#index_commentors', as: 'index_commentors'
  resources :likes, only: %i[show create destroy]
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
