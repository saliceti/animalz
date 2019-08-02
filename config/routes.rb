Rails.application.routes.draw do
  resources :species_records
  resources :genus_records
  resources :family_records
  resources :order_records
  resources :class_records
  resources :phylum_records
  get 'welcome/index'

  resources :families do
    resources :animals
  end
  resources :animals
  root 'welcome#index'
end
