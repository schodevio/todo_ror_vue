# frozen_string_literal: true

json.links do
  json.submit_path user_session_path
  json.redirect_path user_panel_dashboard_path
  json.forgot_password_path new_user_password_path
  json.sign_up_path new_user_registration_path
end
