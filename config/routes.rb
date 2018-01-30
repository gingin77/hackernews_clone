Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: :show
  root to: "home#index"
end
