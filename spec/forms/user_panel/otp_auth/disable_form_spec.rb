# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::OTPAuth::DisableForm do
  describe '#valid?' do
    context 'with happy path' do
      it 'returns true' do
        user = create(:user, password: 'Password123!')
        params = { current_password: 'Password123!' }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(true)
        expect(form.errors).to be_empty
      end
    end

    context 'when password is blank' do
      it 'returns false and produces errors' do
        user = create(:user, password: 'Password123!')
        params = { current_password: '' }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:current_password]).to contain_exactly('is invalid')
      end
    end

    context 'when password is wrong' do
      it 'returns false and produces errors' do
        user = create(:user, password: 'Password123!')
        params = { current_password: 'wrong-password' }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:current_password]).to contain_exactly('is invalid')
      end
    end
  end

  describe '#save' do
    it 'sets otp_required_for_login as false and rotates otp_secret_key' do
      user = create(
        :user,
        password: 'Password123!',
        otp_required_for_login: true
      )

      params = { current_password: 'Password123!' }

      action = lambda do
        described_class.new(user, params: params).save
        user.reload
      end

      expect(&action)
        .to change(user, :otp_required_for_login)
        .to(false)
        .and change(user, :otp_secret_key)
    end
  end
end
