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
      it 'renders show view' do
        user = create(:user)

        sign_in user
        get :show

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
