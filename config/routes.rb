# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'user_panel/passwords',
    registrations: 'user_panel/registrations',
    sessions: 'user_panel/sessions'
  }

  namespace :user_panel, path: :users do
    resources :checklists, only: %i[index show create update destroy] do
      resources :tasks, module: :checklists, only: %i[index create update destroy]
    end

    resource :dashboard, controller: :dashboard, only: :show
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'welcome#index'
end
