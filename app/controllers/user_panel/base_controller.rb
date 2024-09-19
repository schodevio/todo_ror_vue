# frozen_string_literal: true

module UserPanel
  class BaseController < ApplicationController
    include UserPanel::OTPAuthenticable

    before_action :authenticate_user!
    before_action :authenticate_otp!, if: :user_signed_in?

    layout 'user_panel'
  end
end
