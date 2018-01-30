Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  resources :profiles, only: :show
  root to: "home#index"
end
