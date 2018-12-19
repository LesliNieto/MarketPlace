Rails.application.routes.draw do

  root 'products#index'

  resources :users, only: [:index]
  resources :products, only: [:index, :new, :create]

end
