Rails.application.routes.draw do

  root 'products#index'

  devise_for :users
  resources :products
  resources :users, only: [:index, :show, :destroy, :delete]
  get "/dashboard" => "users#dashboard"
  put "/products/:id/publish" => "products#publish"

end
