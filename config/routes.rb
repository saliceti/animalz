Rails.application.routes.draw do
  get 'welcome/index'

  resources :families do
    resources :animals
  end
  resources :animals
  root 'welcome#index'
end
