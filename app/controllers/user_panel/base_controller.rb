# frozen_string_literal: true

module UserPanel
  class BaseController < ApplicationController
    before_action :authenticate_user!
    layout 'user_panel'
  end
end
