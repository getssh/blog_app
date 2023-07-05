Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "users#index"
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :logout
  end
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  get '/users', to: 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments, only: [:new, :create]
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end

  post '/posts/:id/like', to: 'posts#create_like', as: 'like_post'
end
