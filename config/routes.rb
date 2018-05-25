Rails.application.routes.draw do
  root to: "posts#index"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :index]

  resources :posts

  resources :comments, only: [:show, :create] do
    get "reply" => "comments#new", as: :reply_comment
  end

  resources :votes, only: [:create, :update, :destroy]
end
