# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  # devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  get "parking/index"

  resources :parking

  root "application#index"

  get "/registered", to: "parking#registered"
  get "/terms", to: "parking#terms"
  get "/privacy", to: "parking#terms"
  get "/admin", to: "admin#index"
  get "/admin/simple", to: "admin#simple"
  delete "/admin/delete/:id", to: "admin#destroy"
  get "/admin/show/:id", to: "admin#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
