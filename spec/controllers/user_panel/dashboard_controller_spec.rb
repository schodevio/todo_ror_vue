# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::DashboardController, type: :controller do
  describe '#show' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user logged in' do
      context 'when user required otp and was verified' do
        it 'renders show view' do
          user = create(:user, otp_required_for_login: true)

          sign_in user
          request.session['otp_user_id'] = user.id

          get :show

          expect(response).to have_http_status(:ok)
        end
      end

      context 'when user required otp and was not verified yet' do
        it 'redirects to otp auth view' do
          user = create(:user, otp_required_for_login: true)

          sign_in user
          request.session.delete('otp_user_id')

          get :show

          expect(response).to redirect_to user_panel_otp_auth_path
        end
      end
    end
  end
end
