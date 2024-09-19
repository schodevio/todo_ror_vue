# frozen_string_literal: true

module UserPanel
  module OTPAuthenticable
    private

    def authenticate_otp!
      return unless current_user.otp_required_for_login
      return if current_user.otp_verified?(session[:otp_user_id])

      redirect_to user_panel_otp_auth_path
    end
  end
end
