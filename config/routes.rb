Rails.application.routes.draw do
  resources :articles
  get '/articles/search', to: 'articles#search'

  root 'articles#index'
end
