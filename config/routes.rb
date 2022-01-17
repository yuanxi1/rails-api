Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        resources :tasks 
        resources :tags
        patch '/resetpw/:id', to: 'users#update'
        post '/login', to: 'authentications#login'
        post '/register', to: 'users#create'
        get '/search', to: 'tasks#search'
      end
  end
end
