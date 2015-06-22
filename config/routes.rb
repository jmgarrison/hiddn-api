require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :v1 do
    resources :place_types, only: [:index]
    resource :sessions, only: [:create, :destroy]
    resources :users, only: [:create]
  end

end
