Rails.application.routes.draw do

  root 'products#index'

  devise_for :users
  resources :products do
    put "publish", on: :member
  end

  resources :users, only: [:index, :show, :destroy, :delete]
  get "/dashboard" => "users#dashboard"

end
