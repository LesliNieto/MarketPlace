Rails.application.routes.draw do

  root 'products#index'

  devise_for :users
  resources :users, only: [:index, :show]
  resources :products, except: [:edit, :update]

end
