# frozen_string_literal: true

json.links do
  json.submit_path user_panel_otp_auth_path
  json.redirect_path user_panel_dashboard_path
  json.sign_out_path destroy_user_session_path
end
