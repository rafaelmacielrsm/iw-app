Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  } 
  
  get '/profile', to: "user/dashboard#index"

  root to: "home#index"
end
