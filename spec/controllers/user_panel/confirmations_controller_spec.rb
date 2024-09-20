# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::ConfirmationsController, type: :controller do
  describe '#show' do
    context 'when GET method' do
      it 'confirms user' do
        freeze_time
        request.env['devise.mapping'] = Devise.mappings[:user]

        user = create(:user, confirmed_at: nil, confirmation_token: 'sample-token')

        sign_in user

        action = lambda do
          get :show, params: { confirmation_token: 'sample-token' }
          user.reload
        end

        expect(&action).to change(user, :confirmed_at).to(Time.current)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when HEAD method' do
      it 'does not confirm user' do
        freeze_time
        request.env['devise.mapping'] = Devise.mappings[:user]

        user = create(:user, confirmed_at: nil, confirmation_token: 'sample-token')

        sign_in user

        action = lambda do
          head :show, params: { confirmation_token: 'sample-token' }
          user.reload
        end

        expect(&action).to not_change(user, :confirmed_at)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
