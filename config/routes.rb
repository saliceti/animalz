Rails.application.routes.draw do
  resources :taxons

  root 'home#index'

  get 'browse/index'
end
