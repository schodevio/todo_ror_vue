# frozen_string_literal: true

module UserPanel
  class ConfirmationsController < Devise::ConfirmationsController
    layout 'devise'

    clear_respond_to
    respond_to :html, only: %i[new show]
    respond_to :json, only: %i[create]

    def show
      request.head? ? head(:ok) : super
    end

    protected

    def after_confirmation_path_for(*)
      new_user_session_path
    end
  end
end
