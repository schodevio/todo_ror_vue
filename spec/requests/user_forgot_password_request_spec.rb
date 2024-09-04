# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User forgot password', type: :request do
  describe 'new password view' do
    it 'uses devise layout' do
      get '/users/password/new'

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(layout: 'devise')
    end
  end

  describe 'POST /users/password' do
    context 'when valid params' do
      it 'creates reset password token' do
        user = create(:user, email: 'john@example.com')

        params = {
          user: {
            email: 'john@example.com'
          }
        }

        action = lambda do
          post '/users/password', params: params, as: :json
          user.reload
        end

        expect(&action)
          .to change(user, :reset_password_token)
          .from(nil)
          .to(String)

        expect(response).to have_http_status(:created)
      end
    end
  end
end
