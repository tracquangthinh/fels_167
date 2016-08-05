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

  resources :users
  namespace :admin do
    resources :categories do
      resources :words
    end
  end
  resources :categories do
    resources :words
    resources :lessons
  end
  resources :results
  resources :words
  resources :lessons
end
