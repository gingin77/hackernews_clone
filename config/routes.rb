Rails.application.routes.draw do
  root to: "posts#index"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: :show

  resources :posts do
    resources :comments, only: [:new, :create]
  end
end
