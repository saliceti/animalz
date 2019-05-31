Rails.application.routes.draw do
  get 'welcome/index'

  resources :animals

  root 'welcome#index'
end
