# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::SessionsController, type: :controller do
  describe '#destroy' do
    context 'when user otp verified' do
      it 'drops otp_user_id key from session' do
        request.env['devise.mapping'] = Devise.mappings[:user]
        user = create(:user, otp_required_for_login: true)

        sign_in user
        request.session['otp_user_id'] = user.id

        delete :destroy

        expect(response).to redirect_to(root_path)
        expect(request.session).not_to have_key('otp_user_id')
      end
    end
  end
end
