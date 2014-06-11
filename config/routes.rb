Rails.application.routes.draw do
  root 'articles#index'
  get 'articles/new' => 'articles#new'
  get 'articles' => 'articles#create'
end
