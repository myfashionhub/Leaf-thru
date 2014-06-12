Rails.application.routes.draw do
  root 'welcome#index'
  resources :articles
  
  get 'auth/:provider' => 'sessions#authorize'
  get 'auth/:provider/callback' => 'sessions#log'

  get '/signup' => 'readers#new', as: 'signup'
  # Authenticate with Fb, Twitter then customize profile
  post '/readers'=> 'readers#create'

  get '/login' => 'sessions#new', as: 'login'
  # Sign in with Fb/Twitter
  post '/sessions' => 'sessions#create', as: 'sessions'
  get '/logout' => 'sessions#destroy', as: 'logout'

  get 'profile' => 'readers#profile', as: 'profile'  
end
