# frozen_string_literal: true

json.otp_auth do
  json.extract! @enable_form.user, :otp_required_for_login, :otp_backup_codes
end
