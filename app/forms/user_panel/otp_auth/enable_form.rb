# frozen_string_literal: true

module UserPanel
  module OTPAuth
    class EnableForm
      include ActiveModel::Model

      attr_reader :user
      attr_accessor :current_password, :otp_code

      validate :current_password_accuracy
      validate :otp_code_accuracy

      def initialize(user, params:)
        @user = user

        super(params)
      end

      def save
        return false unless valid?

        user.update(otp_required_for_login: true)
      end

      private

      def current_password_accuracy
        return if user.valid_password?(current_password)

        errors.add(:current_password, 'is invalid')
      end

      def otp_code_accuracy
        return if user.authenticate_otp(otp_code)

        errors.add(:otp_code, 'is invalid')
      end
    end
  end
end
