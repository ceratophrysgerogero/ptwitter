Rails.application.routes.draw do
  root 'home_pages#home'
  resources :microposts, only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
