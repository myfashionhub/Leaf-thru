Rails.application.routes.draw do
  root 'welcome#index'
  resources :articles, only: [:index, :create, :show, :destroy]
  resources :reader_article_join
  resources :reader_interest_join
  resources :publications

  get 'signup'  => 'readers#new', as: 'signup'
  post 'readers'=> 'readers#create'
  get 'profile' => 'readers#profile', as: 'profile'
  post 'profile' => 'readers#update', as: 'update_reader'
  get 'profile/edit' => 'readers#edit', as: 'reader'
  patch 'profile'=> 'readers#update'



  get 'login'   => 'sessions#new', as: 'login'
  post 'sessions'=> 'sessions#create', as: 'sessions'
  get 'logout'  => 'sessions#destroy', as: 'logout'

  get 'about'   => 'welcome#about'

  get 'auth/:provider'        => 'sessions#authorize'
  get 'auth/twitter/callback' => 'sessions#log_twitter'
  get 'auth/facebook/callback'=> 'sessions#log_facebook'

  get 'twitter' => 'readers#twitter'
  get 'facebook' => 'readers#facebook'
  get 'feed'    => 'readers#feed'
end

