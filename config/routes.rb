require 'resque/server'
require 'resque/scheduler/server'
Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :applications, :except => ['update', 'show']
      put '/applications/:app_token' => 'applications#update'
      get '/applications/:app_token' => 'applications#show'
    end
  end
  # resources :posts, :except => ['show', 'update', 'destroy']
  # get    'posts/:id/:slug' => 'posts#show', :as => 'post'
  # put    'posts/:id/:slug' => 'posts#update'
  # delete 'posts/:id/:slug' => 'posts#destroy'

  mount Resque::Server.new, at: "/resque"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
