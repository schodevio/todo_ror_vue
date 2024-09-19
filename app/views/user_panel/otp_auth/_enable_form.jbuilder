# frozen_string_literal: true

json.otp_auth do
  json.extract! current_user, :otp_required_for_login

  json.otp_secret_key current_user.otp_secret_key.downcase
  json.qrcode_svg url_to_qrcode(current_user.otp_auth_url).html_safe # rubocop:disable Rails/OutputSafety

  json.links do
    json.otp_auth_path user_panel_otp_auth_path
  end
end
