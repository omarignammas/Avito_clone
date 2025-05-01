# config/routes.rb
Rails.application.routes.draw do
  # Route racine (page d'accueil)
  root 'home#index'
  
  # Authentification
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get '/auth/failure', to: redirect('/')
  post '/listings/new', to: 'listings#create'

  
  # Listings (annonces)
  resources :listings do
    collection do
      get 'search'
    end
    resources :images, only: [:create, :destroy]
  end
  
  # Categories
  resources :categories, only: [:show]
  
  # Profil utilisateur et tableau de bord
  resources :users, only: [:show, :new, :create]
  namespace :dashboard do
    root to: 'dashboard#index'
    resources :listings
    resources :favorites
    resources :messages
  end
  
  # Routes pour la navigation principale
  get '/auto-neuf', to: 'categories#auto_neuf'
  get '/immo-neuf', to: 'categories#immo_neuf'
  get '/credit-immobilier', to: 'categories#credit_immobilier'
  get '/credit-conso', to: 'categories#credit_conso'
  get '/boutiques', to: 'categories#boutiques'
  get '/magazine', to: 'categories#magazine'
  
  # Vérification de santé de l'application
  get "up" => "rails/health#show", as: :rails_health_check
end