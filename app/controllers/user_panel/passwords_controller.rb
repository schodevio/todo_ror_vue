# frozen_string_literal: true

module UserPanel
  class PasswordsController < Devise::PasswordsController
    layout 'devise'

    clear_respond_to
    respond_to :html, only: %i[new edit]
    respond_to :json, only: %i[create update]
  end
end
