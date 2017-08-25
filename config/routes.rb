Rails.application.routes.draw do
  resources :articles
  get '/articles/search', to: 'articles#search'
end
