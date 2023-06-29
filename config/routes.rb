Rails.application.routes.draw do

  root to: "pages#home"
  resources :profiles
  resources :matchings, only: [:new, :create, :index]
  get 'matchings', to: 'matchings#index'
  get '/division_matches', to: 'division_matches#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
