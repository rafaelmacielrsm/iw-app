Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  } 

  root to: "home#index"

  namespace :user, path: '/' do
    get '/profile', to: "dashboard#index", as: 'profile'
    resource :diets, only: [:new, :create, :show]
  end
end
