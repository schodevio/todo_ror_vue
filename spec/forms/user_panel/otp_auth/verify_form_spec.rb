# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::OTPAuth::VerifyForm do
  describe '#valid?' do
    context 'with happy path' do
      it 'returns true' do
        freeze_time

        user = create(:user)
        params = { otp_code: user.otp_code }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(true)
        expect(form.errors).to be_empty
      end
    end

    context 'when OTP code is blank' do
      it 'returns false and produces errors' do
        freeze_time

        user = create(:user)
        params = { otp_code: '' }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:otp_code]).to contain_exactly('is invalid')
      end
    end

    context 'when OTP code is wrong' do
      it 'returns false and produces errors' do
        freeze_time

        user = create(:user)
        params = { otp_code: '123' }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:otp_code]).to contain_exactly('is invalid')
      end
    end
  end

  describe '#call' do
    context 'when OTP code is valid' do
      it 'does not send notification' do
        freeze_time

        user = create(:user)
        params = { otp_code: user.otp_code }

        action = -> { described_class.new(user, params: params).call }

        expect(&action).to not_have_enqueued_mail(UserPanel::UserMailer, :failed_login_attempt)
      end
    end

    context 'when OTP code is wrong' do
      it 'sends notification to user' do
        freeze_time

        user = create(:user)
        params = { otp_code: '123' }

        action = -> { described_class.new(user, params: params).call }

        expect(&action).to have_enqueued_mail(UserPanel::UserMailer, :failed_login_attempt)
      end
    end
  end
end
