Rails.application.routes.draw do
  resources :taxons
  resources :animons
  resources :animon_links
  resources :youtube_videos
  resources :getty_images

  root 'home#index'

  get 'browse/index'
  get 'help/index'
  get 'taxonomy/index'
end
