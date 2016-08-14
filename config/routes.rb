Rails.application.routes.draw do
  root 'welcome#index'

  resources :readers, only: [:create, :update]
  post '/profile'     => 'readers#update'
  get 'profile'       => 'readers#show'

  get '/feed'           => 'feeds#index'
  get '/feeds/twitter'  => 'feeds#twitter'
  get '/feeds/rss'      => 'feeds#rss'

  resources :articles,     only: [:index, :create, :show, :destroy]
  resources :publications, only: [:index]
  resources :subscriptions, only: [:create, :index]

  get 'leafers'         => 'bookmarks#index'
  post 'sessions'       => 'sessions#create', as: 'sessions'
  get 'logout'          => 'sessions#destroy', as: 'logout'
  get 'about'           => 'welcome#about'

  get 'auth/twitter/callback' => 'sessions#log_twitter'
  get 'auth/facebook/callback'=> 'sessions#log_facebook'
  get 'auth/pocket'           => 'sessions#request_pocket'
  get 'auth/pocket/callback'  => 'sessions#authorize_pocket'
  get 'logout/facebook'       => 'sessions#logout_fb'
  get 'logout/twitter'        => 'sessions#logout_tw'

end

