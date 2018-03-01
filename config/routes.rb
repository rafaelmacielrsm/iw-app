Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  } 

  root to: "home#index"

  namespace :user, path: '/' do
    get '/profile', to: "dashboard#index", as: 'profile'

    resources :diets, only: [:new, :create, :show] do
      resource :diet_progress, only: [ :create ], as: 'progress'
    end
  end
end
