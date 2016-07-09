Rails.application.routes.draw do

  namespace :v1 do
    resource :sessions, only: [:create, :destroy]
    resources :users, only: [:create]
  end

end
