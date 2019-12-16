Rails.application.routes.draw do
  get 'sessions/new'
  root 'home_pages#home'
  resources :users
  resources :microposts, only: [:create, :destroy]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
