Rails.application.routes.draw do
  root 'welcome#index'
  get 'about'          => 'welcome#about'

  # Reader information
  resources :readers, only: [:create, :update]
  post '/profile'      => 'readers#update'
  get '/profile'       => 'readers#profile'
  resources :articles,     only: [:index, :create, :show, :destroy]

  # Feed
  get '/feed'          => 'feeds#index'
  get '/feeds/twitter' => 'feeds#twitter'

  # Session
  post 'sessions'      => 'sessions#create', as: 'sessions'
  get 'logout'         => 'sessions#destroy', as: 'logout'

  # Third-party authorization
  get 'auth/pocket'            => 'sessions#request_pocket'
  get 'auth/:service/callback' => 'sessions#authorize'
  get 'disconnect/:service'    => 'sessions#unauthorize'
end

