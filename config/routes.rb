Rails.application.routes.draw do
  root 'welcome#index'
  resources :articles

  get 'signup'  => 'readers#new', as: 'signup'
  post 'readers'=> 'readers#create'
  get 'profile' => 'readers#profile', as: 'reader' 
  post 'profile'=> 'readers#update'

  get 'login'   => 'sessions#new', as: 'login'
  post 'sessions'=> 'sessions#create', as: 'sessions'
  get 'logout'  => 'sessions#destroy', as: 'logout' 

  get 'about'   => 'welcome#about' 
end

