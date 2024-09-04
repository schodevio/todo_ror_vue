# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signup', type: :request do
  describe 'signup view' do
    it 'uses devise layout' do
      get '/users/sign_up'

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(layout: 'devise')
    end
  end

  describe 'POST /users' do
    it 'creates new user' do
      params = {
        user: {
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@example.com',
          password: 'Password123!',
          password_confirmation: 'Password123!'
        }
      }

      action = -> { post '/users', params: params, as: :json }

      expect(&action).to change(User, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end
end
