require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :v1 do
    resource :sessions, only: [:create, :destroy]
    resource :users, only: [:create]
  end

end
