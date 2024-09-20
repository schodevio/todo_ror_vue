# frozen_string_literal: true

module UserPanel
  class OTPAuthController < BaseController
    skip_before_action :authenticate_otp!, only: %i[show update]

    layout 'devise'

    respond_to :json, :html

    # View with a form to verify OTP code after sign in
    def show; end

    # Action to enable 2FA
    def create
      session[:otp_user_id] = current_user.id if enable_form.save

      respond_with enable_form
    end

    # Action to verify OTP code after sign in
    def update
      session[:otp_user_id] = current_user.id if verify_form.call

      respond_with verify_form
    end

    # Action to disable 2FA
    def destroy
      session.delete(:otp_user_id) if disable_form.save

      respond_with disable_form
    end

    private

    def enable_form
      @enable_form ||= OTPAuth::EnableForm.new(current_user, params: enable_params)
    end

    def enable_params
      params.require(:otp_auth).permit(:current_password, :otp_code)
    end

    def verify_form
      @verify_form ||= OTPAuth::VerifyForm.new(current_user, params: verify_params)
    end

    def verify_params
      params.require(:otp_auth).permit(:otp_code)
    end

    def disable_form
      @disable_form ||= OTPAuth::DisableForm.new(current_user, params: disable_params)
    end

    def disable_params
      params.require(:otp_auth).permit(:current_password)
    end
  end
end
