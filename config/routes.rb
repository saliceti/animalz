Rails.application.routes.draw do
  resources :taxons
  resources :animons
  resources :youtube_videos

  root 'home#index'

  get 'browse/index'
  get 'help/index'
  get 'taxonomy/index'
end
