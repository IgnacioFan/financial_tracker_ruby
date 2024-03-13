Rails.application.routes.draw do
  root "dashboard#index"
  resources :users
  resources :products
end
