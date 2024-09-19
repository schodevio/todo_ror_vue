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
end
