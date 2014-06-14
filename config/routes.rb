Rails.application.routes.draw do
  root 'welcome#index'
  resources :articles

  get 'signup'  => 'readers#new', as: 'signup'
  post 'readers'=> 'readers#create'
  get 'profile' => 'readers#profile', as: 'profile'
  get 'profile/edit' => 'readers#edit', as: 'reader' 
  patch 'profile'=> 'readers#update'

  get 'login'   => 'sessions#new', as: 'login'
  post 'sessions'=> 'sessions#create', as: 'sessions'
  get 'logout'  => 'sessions#destroy', as: 'logout' 

  get 'about'   => 'welcome#about' 

  get 'auth/:provider'        => 'sessions#authorize'
  get 'auth/twitter/callback' => 'sessions#log' 
  get 'auth/facebook/callback'=> 'sessions#logfb' 

  get 'twitter' => 'readers#twitter' 
  get 'feed'    => 'readers#feed'
end

