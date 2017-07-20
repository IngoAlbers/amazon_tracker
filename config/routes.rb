Rails.application.routes.draw do
  resources :articles, only: :index
  get '/articles/search', to: 'articles#search'
end
