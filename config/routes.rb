# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'user_panel/confirmations',
    passwords: 'user_panel/passwords',
    registrations: 'user_panel/registrations',
    sessions: 'user_panel/sessions'
  }

  devise_scope :user do
    get 'users/thank_you', to: 'user_panel/registrations#thank_you'
  end

  namespace :user_panel, path: :users do
    resources :checklists, only: %i[index show create update destroy] do
      resources :tasks, module: :checklists, only: %i[index create update destroy]

      member do
        get :export
        post :send_email
      end
    end

    resource :dashboard, controller: :dashboard, only: :show
    resource :otp_auth, controller: :otp_auth, only: %i[show create update destroy]
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'welcome#index'
end
