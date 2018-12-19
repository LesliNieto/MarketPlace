Rails.application.routes.draw do

  root 'products#index'

  resources :products, except: [:edit, :update, :destroy, :delete ]
  resources :users, only: [:index, :new, :create]

end
