Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registration: 'users/registrations'
  }
  # Add a custom registration route
  post '/users/registrations', to: 'users/registrations#create'
  delete '/users/sign_out', to: 'users/sessions#destroy' # Sign-out route
  get '/memeber_details' => 'members#index'

  #resources :companies

  namespace :api do
    namespace :v1 do
      resources :companies
    end
  end # this is done in non api-only application(full stack application)


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
