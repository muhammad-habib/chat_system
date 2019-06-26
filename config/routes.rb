Rails.application.routes.draw do
  resources :messsages
  resources :chats
  namespace :api do
    namespace :v1 do
      resources :applications, :except => ['update', 'show']
      put '/applications/:app_token' => 'applications#update'
      get '/applications/:app_token' => 'applications#show'
      resources :chats, :except => ['update', 'show', 'create']
      post '/applications/:app_token/chats' => 'chats#create'
      get '/applications/:app_token/chats' => 'chats#index'
      resources :messages, :except => ['update', 'show', 'create']
      post '/applications/:app_token/chats/:chat_number/messages' => 'messages#create'
      get '/applications/:app_token/chats/:chat_number/messages' => 'messages#index'
      post '/applications/:app_token/chats/:chat_number/messages/search' => 'messages#search'
    end
  end
  require 'sidekiq/web'
  require 'sidekiq-status/web'

  mount Sidekiq::Web => '/sidekiq'
end
