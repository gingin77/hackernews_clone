Rails.application.routes.draw do
  root to: "posts#index"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: :show

  resources :posts do
    resources :comments, only: :create
  end

  resources :comments, only: :show do
    get "reply" => "comments#new", as: :reply_comment
    post "reply" => "comments#create"
  end

  resources :votes, only: [:create, :update, :destroy]
end
