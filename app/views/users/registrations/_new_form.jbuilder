# frozen_string_literal: true

json.links do
  json.submit_path user_registration_path
  json.redirect_path new_user_session_path
  json.sign_in_path new_user_session_path
end
