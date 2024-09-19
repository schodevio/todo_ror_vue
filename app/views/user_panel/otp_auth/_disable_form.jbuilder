# frozen_string_literal: true

json.otp_auth do
  json.extract! current_user, :otp_required_for_login

  json.links do
    json.otp_auth_path user_panel_otp_auth_path
  end
end
