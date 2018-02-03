Rails.application.routes.draw do
  root to: "submissions#index"

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, only: :show
  resources :submissions
end
