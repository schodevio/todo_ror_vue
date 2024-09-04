# frozen_string_literal: true

module UserPanel
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    layout 'devise'

    clear_respond_to
    respond_to :html, only: %i[new]
    respond_to :json, only: %i[create]

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    end
  end
end
