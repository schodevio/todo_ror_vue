# frozen_string_literal: true

module UserPanel
  class SessionsController < Devise::SessionsController
    layout 'devise'

    clear_respond_to
    respond_to :html, only: %i[new]
    respond_to :json, only: %i[create]

    def destroy
      super do
        session.delete(:opt_user_id)
      end
    end
  end
end
