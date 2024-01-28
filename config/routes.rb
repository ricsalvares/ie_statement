# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'statements/index'
      post 'statements/create'
      get 'statement/show/:id', to: 'statements#show'
      put 'statements/:id', to: 'statements#update'
      delete 'statements/delete/:id', to: 'statements#destroy'
    end
  end
  devise_for :users
  resources :statements
  root 'statements#index'

  get 'react' => 'react_statements#index'
  get '/*path' => 'react_statements#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
