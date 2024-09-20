# frozen_string_literal: true

module UserPanel
  module OTPAuth
    class VerifyForm
      include ActiveModel::Model

      attr_reader :user, :params
      attr_accessor :otp_code

      validate :otp_code_accuracy

      def initialize(user, params:)
        @user = user

        super(params)
      end

      def call
        return true if valid?

        UserPanel::UserMailer.with(user: user).failed_login_attempt.deliver_later

        false
      end

      private

      def otp_code_accuracy
        return if user.authenticate_otp(otp_code)

        errors.add(:otp_code, 'is invalid')
      end
    end
  end
end
