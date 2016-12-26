Rails.application.routes.draw do
  root 'welcome#index'
  get 'about'          => 'welcome#about'

  # Reader information
  resources :readers, only: [:create, :update]
  get '/customize'     => 'readers#customize'
  post '/profile'      => 'readers#update'
  get '/profile'       => 'readers#show'
  resources :articles,     only: [:index, :create, :show, :destroy]
  resources :publications, only: [:index]
  resources :subscriptions, only: [:create, :index]

  # Feed
  get '/feed'          => 'feeds#index'
  get '/feeds/twitter' => 'feeds#twitter'
  get '/feeds/rss'     => 'feeds#rss'

  # Session
  post 'sessions'      => 'sessions#create', as: 'sessions'
  get 'logout'         => 'sessions#destroy', as: 'logout'

  # Third-party authorization
  get 'auth/pocket'            => 'sessions#request_pocket'
  get 'auth/:service/callback' => 'sessions#authorize'
  get 'disconnect/:service'    => 'sessions#unauthorize'

  # Inactive
  get 'leafers'         => 'bookmarks#index'
end

