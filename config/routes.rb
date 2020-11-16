Rails.application.routes.draw do
  resources :taxons
  resources :youtube_videos

  root 'home#index'

  get 'browse/index'
  get 'help/index'
end
