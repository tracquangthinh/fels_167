Rails.application.routes.draw do

  get "/help", to: "static_pages#help"
  get "/about",to: "static_pages#about"
  get "/home", to: "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :user
  root "static_pages#home"
end
