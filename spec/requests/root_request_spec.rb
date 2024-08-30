# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root', type: :request do
  describe 'GET /' do
    it 'renders view with status 200' do
      get '/'

      expect(response).to have_http_status(:ok)
    end
  end
end
