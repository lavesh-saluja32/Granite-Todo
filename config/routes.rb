# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks, only: [:index, :show], param: :slug

  root "home#index"
  get "*path", to: "home#index", via: :all
end
