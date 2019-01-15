Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'products#index'

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :products do
    put "publish", on: :member
  end

  resources :users, only: [:index, :show, :destroy, :delete]
  get "/dashboard" => "users#dashboard"

end
