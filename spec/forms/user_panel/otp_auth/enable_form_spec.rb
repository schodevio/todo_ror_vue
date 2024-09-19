# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::OTPAuth::EnableForm do
  describe '#valid?' do
    context 'with happy path' do
      it 'returns true' do
        freeze_time
        user = create(:user, password: 'Password123!')

        params = {
          current_password: 'Password123!',
          otp_code: user.otp_code
        }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(true)
        expect(form.errors).to be_empty
      end
    end

    context 'when password is blank' do
      it 'returns false and produces errors' do
        freeze_time
        user = create(:user, password: 'Password123!')

        params = {
          current_password: '',
          otp_code: user.otp_code
        }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:current_password]).to contain_exactly('is invalid')
      end
    end

    context 'when password is wrong' do
      it 'returns false and produces errors' do
        freeze_time
        user = create(:user, password: 'Password123!')

        params = {
          current_password: 'wrong-password',
          otp_code: user.otp_code
        }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:current_password]).to contain_exactly('is invalid')
      end
    end

    context 'when OTP code is blank' do
      it 'returns false and produces errors' do
        freeze_time
        user = create(:user, password: 'Password123!')

        params = {
          current_password: 'Password123!',
          otp_code: ''
        }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:otp_code]).to contain_exactly('is invalid')
      end
    end

    context 'when OTP code is wrong' do
      it 'returns false and produces errors' do
        freeze_time
        user = create(:user, password: 'Password123!')

        params = {
          current_password: 'Password123!',
          otp_code: '123'
        }

        form = described_class.new(user, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:otp_code]).to contain_exactly('is invalid')
      end
    end
  end

  describe '#save' do
    it 'sets otp_required_for_login as true' do
      freeze_time

      user = create(
        :user,
        password: 'Password123!',
        otp_required_for_login: false
      )

      params = {
        current_password: 'Password123!',
        otp_code: user.otp_code
      }

      action = lambda do
        described_class.new(user, params: params).save
        user.reload
      end

      expect(&action).to change(user, :otp_required_for_login).to(true)
    end
  end
end
