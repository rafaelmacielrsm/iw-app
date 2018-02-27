Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  } 
  
  # get '/profile', to: "user/dashboard#index"

  # resources :diet, only: [:show]

  root to: "home#index"

  namespace :user, path: '/' do
    get '/profile', to: "dashboard#index", as: 'profile'
  end
end
