Rails.application.routes.draw do
  root 'welcome#index'
  resources :articles
  get 'auth/:provider' => 'sessions#authorize'
  get 'auth/:provider/callback' => 'sessions#log'
end
