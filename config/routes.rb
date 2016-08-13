Rails.application.routes.draw do
  get "/help", to: "static_pages#help"
  get "/about",to: "static_pages#about"
  get "/home", to: "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/lessons/new", to: "lessons#create"
  root "static_pages#home"

  resources :users, only: [:new, :create, :show, :edit, :update, :index] do
    member do
      get :following, :followers
    end
  end
  namespace :admin do
    resources :categories do
      resources :words
      collection { post :import }
    end
    resources :words
    resources :lessons
  end
  resources :words
  resources :lessons
  resources :categories do
    resources :results, only: [:show, :index]
  end
  resources :results, only: [:show, :index]
  resources :relationships, only: [:create, :destroy]
end
