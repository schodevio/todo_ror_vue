# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signin', type: :request do
  describe 'signin view' do
    it 'uses devise layout' do
      get '/users/sign_in'

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(layout: 'devise')
    end
  end

  describe 'POST /users/sign_in' do
    context 'when valid params' do
      it 'authenticates user' do
        create(:user, email: 'john@example.com', password: 'Password123!')

        params = {
          user: {
            email: 'john@example.com',
            password: 'Password123!'
          }
        }

        post '/users/sign_in', params: params, as: :json

        expect(response).to have_http_status(:created)
      end
    end

    context 'when invalid params' do
      it 'responds with unauthorized error' do
        params = {
          user: {
            email: 'john@example.com',
            password: 'Password123!'
          }
        }

        post '/users/sign_in', params: params, as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
