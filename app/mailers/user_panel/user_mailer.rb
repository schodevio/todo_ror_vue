# frozen_string_literal: true

module UserPanel
  class UserMailer < ApplicationMailer
    def failed_login_attempt
      @user = params[:user]

      mail(
        to: @user.email,
        subject: '[App Name] Failed login attempt'
      )
    end
  end
end
