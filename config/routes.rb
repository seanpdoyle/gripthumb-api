require 'sidekiq/web'

Gripthumb::Application.routes.draw do
  mount Sidekiq::Web => '/queue'
  resources :songs do
    post 'identify', to: 'songs#identify', on: :collection
  end
end
