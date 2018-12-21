Rails.application.routes.draw do

  root 'products#index'

  devise_for :users
  resources :products, except: [:edit, :update, :destroy, :delete ]
  resources :users, only: [:index, :show]

end
