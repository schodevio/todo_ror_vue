# frozen_string_literal: true

json.links do
  json.submit_path user_password_path
  json.redirect_path user_panel_dashboard_path
  json.sign_in_path new_user_session_path
end
