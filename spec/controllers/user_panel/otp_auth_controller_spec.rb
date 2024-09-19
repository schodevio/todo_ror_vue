# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::OTPAuthController, type: :controller do
  describe '#show' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user logged in' do
      it 'renders show view' do
        user = create(:user)

        sign_in user
        get :show

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#create' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        post :create, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when valid params' do
        it 'switches otp_required_for_login to true and responds with backup codes' do
          freeze_time

          user = create(
            :user,
            password: 'Password123!',
            otp_required_for_login: false
          )

          params = {
            otp_auth: {
              current_password: 'Password123!',
              otp_code: user.otp_code
            }
          }

          sign_in user

          action = lambda do
            post :create, params: params, as: :json
            user.reload
          end

          expect(&action).to change(user, :otp_required_for_login).to(true)
          expect(response).to have_http_status(:ok)

          expect(response.parsed_body['otp_auth'])
            .to include(
              'otp_backup_codes' => user.otp_backup_codes,
              'otp_required_for_login' => true
            )
        end
      end

      context 'when invalid params' do
        it 'responds with errors' do
          freeze_time

          user = create(
            :user,
            password: 'Password123!',
            otp_required_for_login: false
          )

          params = {
            otp_auth: {
              current_password: 'wrong-password',
              otp_code: user.otp_code
            }
          }

          sign_in user

          action = lambda do
            post :create, params: params, as: :json
            user.reload
          end

          expect(&action).to not_change(user, :otp_required_for_login)
          expect(response).to have_http_status(:unprocessable_entity)

          expect(response.parsed_body.dig('errors', 'current_password'))
            .to contain_exactly('is invalid')
        end
      end
    end
  end

  describe '#update' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        put :update
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        put :update, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when valid params' do
        it 'sets otp_user_id in session' do
          freeze_time

          user = create(:user, otp_required_for_login: true)

          params = {
            otp_auth: {
              otp_code: user.otp_code
            }
          }

          sign_in user
          request.session.delete('otp_user_id')

          put :update, params: params, as: :json

          expect(response).to have_http_status(:no_content)
          expect(request.session['otp_user_id']).to eq(user.id)
        end
      end

      context 'when invalid params' do
        it 'responds with errors' do
          freeze_time

          user = create(:user, otp_required_for_login: true)

          params = {
            otp_auth: {
              otp_code: '123'
            }
          }

          sign_in user
          request.session.delete('otp_user_id')

          put :update, params: params, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body.dig('errors', 'otp_code')).to contain_exactly('is invalid')
        end
      end
    end
  end

  describe '#destroy' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        delete :destroy
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        delete :destroy, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user fully logged in' do
      context 'when valid params' do
        it 'switches otp_required_for_login to false' do
          freeze_time

          user = create(:user, password: 'Password123!', otp_required_for_login: true)
          params = { current_password: 'Password123!' }

          sign_in user
          request.session['otp_user_id'] = user.id

          action = lambda do
            delete :destroy, params: params, as: :json
            user.reload
          end

          expect(&action).to change(user, :otp_required_for_login).to(false)
          expect(response).to have_http_status(:no_content)
          expect(request.session).not_to have_key('otp_user_id')
        end
      end

      context 'when invalid params' do
        it 'responds with errors' do
          freeze_time

          user = create(:user, password: 'Password123!', otp_required_for_login: true)
          params = { current_password: 'wrong-password' }

          sign_in user
          request.session['otp_user_id'] = user.id

          action = lambda do
            delete :destroy, params: params, as: :json
            user.reload
          end

          expect(&action).to not_change(user, :otp_required_for_login)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(request.session).to have_key('otp_user_id')

          expect(response.parsed_body.dig('errors', 'current_password'))
            .to contain_exactly('is invalid')
        end
      end
    end
  end
end
