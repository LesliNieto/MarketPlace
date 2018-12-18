Rails.application.routes.draw do
  resources :users, only: [:index]
  root 'products#index'
  resources :products, only: [:index]
end
