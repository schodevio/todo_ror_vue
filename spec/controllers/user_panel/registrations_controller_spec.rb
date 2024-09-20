# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::RegistrationsController, type: :controller do
  describe '#create' do
    it 'responds with created status' do
      request.env['devise.mapping'] = Devise.mappings[:user]

      params = {
        user: {
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@example.com',
          password: 'Password123!',
          password_confirmation: 'Password123!'
        }
      }

      action = -> { post :create, params: params, as: :json }

      expect(&action).to change(User, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe '#thank_you' do
    it 'renders thank you view' do
      request.env['devise.mapping'] = Devise.mappings[:user]

      get :thank_you
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#edit' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        request.env['devise.mapping'] = Devise.mappings[:user]

        get :edit
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user logged in' do
      context 'when user otp is nor required' do
        it 'renders edit view' do
          request.env['devise.mapping'] = Devise.mappings[:user]
          user = create(:user, otp_required_for_login: false)

          sign_in user
          get :edit

          expect(response).to have_http_status(:ok)
        end
      end

      context 'when user otp was verified' do
        it 'renders edit view' do
          request.env['devise.mapping'] = Devise.mappings[:user]
          user = create(:user, otp_required_for_login: true)

          sign_in user
          request.session['otp_user_id'] = user.id

          get :edit

          expect(response).to have_http_status(:ok)
        end
      end

      context 'when user otp was not verified yes' do
        it 'redirects to otp auth view' do
          request.env['devise.mapping'] = Devise.mappings[:user]
          user = create(:user, otp_required_for_login: true)

          sign_in user
          request.session.delete('otp_user_id')

          get :edit

          expect(response).to redirect_to user_panel_otp_auth_path
        end
      end
    end
  end
end
