Rails.application.routes.draw do
  get 'users/new'
  root 'home_pages#home'
end
