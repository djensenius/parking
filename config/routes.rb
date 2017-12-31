# frozen_string_literal: true

Rails.application.routes.draw do
  get "parking/index"

  resources :parking

  root "application#index"

  get "/registered", to: "parking#registered"
  get "/admin", to: "admin#index"
  delete "/admin/delete/:id", to: "admin#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
