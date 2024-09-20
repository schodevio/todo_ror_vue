# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::UserMailer, type: :mailer do
  describe 'failed_login_attempt' do
    it 'defines mail' do
      user = create(:user, email: 'john@example.com')

      mail = described_class.with(user: user).failed_login_attempt

      expect(mail.to).to contain_exactly(user.email)
      expect(mail.subject).to eq '[App Name] Failed login attempt'
    end
  end
end
