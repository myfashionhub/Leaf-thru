Rails.application.routes.draw do
  root 'welcome#index'
  resources :articles, only: [:index, :create, :show, :destroy]
  resources :publications

  resources :subscriptions, only: [:create]

  post 'readers'=> 'readers#create'
  get 'profile' => 'readers#profile', as: 'profile'
  post 'profile' => 'readers#update'
  get 'profile/edit' => 'readers#edit', as: 'reader'
  patch 'profile/edit'=> 'readers#update'

  post 'sessions'=> 'sessions#create', as: 'sessions'
  get 'logout'  => 'sessions#destroy', as: 'logout'

  get 'auth/:provider'        => 'sessions#authorize'
  get 'auth/twitter/callback' => 'sessions#log_twitter'
  get 'auth/facebook/callback'=> 'sessions#log_facebook'
  get 'logout/facebook'       => 'sessions#logout_fb'
  get 'logout/twitter'        => 'sessions#logout_tw'

  get 'about'   => 'welcome#about'
  get 'twitter' => 'readers#twitter'
  get 'feed'    => 'readers#feed'
  get 'leafers' => 'bookmarks#index'
end

