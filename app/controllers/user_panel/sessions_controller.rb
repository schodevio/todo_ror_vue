# frozen_string_literal: true

module UserPanel
  class SessionsController < Devise::SessionsController
    layout 'devise'

    clear_respond_to
    respond_to :html, only: %i[new]
    respond_to :json, only: %i[create]
  end
end
