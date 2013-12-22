Gripthumb::Application.routes.draw do
  resources :songs do
    post 'identify', to: 'songs#identify', on: :collection
  end
end
