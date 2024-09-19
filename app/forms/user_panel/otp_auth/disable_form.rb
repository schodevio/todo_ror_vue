# frozen_string_literal: true

module UserPanel
  module OTPAuth
    class DisableForm
      include ActiveModel::Model

      attr_reader :user
      attr_accessor :current_password

      validate :current_password_accuracy

      def initialize(user, params:)
        @user = user

        super(params)
      end

      def save
        return false unless valid?

        user.update(
          otp_secret_key: User.otp_random_secret,
          otp_required_for_login: false
        )
      end

      private

      def current_password_accuracy
        return if user.valid_password?(current_password)

        errors.add(:current_password, 'is invalid')
      end
    end
  end
end
