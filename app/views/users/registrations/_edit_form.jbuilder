# frozen_string_literal: true

json.user do
  json.partial! 'users/user', user: current_user
end

json.links do
  json.submit_path user_registration_path
  json.redirect_path edit_user_registration_path
end
