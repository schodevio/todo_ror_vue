# frozen_string_literal: true

module UserPanel
  class RegistrationsController < Devise::RegistrationsController
    include UserPanel::OTPAuthenticable

    before_action :authenticate_otp!, if: :user_signed_in?, except: %i[new create]
    before_action :configure_permitted_parameters

    layout :set_layout

    clear_respond_to
    respond_to :html, only: %i[new edit]
    respond_to :json, only: %i[create update]

    def thank_you
      render template: 'users/registrations/thank_you'
    end

    protected

    def after_inactive_sign_up_path_for(*)
      users_thank_you_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
    end

    def set_layout
      user_signed_in? ? 'user_panel' : 'devise'
    end
  end
end
