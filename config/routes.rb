Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        resources :tasks 
        post '/login', to: 'authentications#login'
        post '/register', to: 'users#create'
      end
  end
end
