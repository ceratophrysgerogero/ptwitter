Rails.application.routes.draw do
  root 'home_pages#home'
  resources :users
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
