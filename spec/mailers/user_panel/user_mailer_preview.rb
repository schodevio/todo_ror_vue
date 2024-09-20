# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers

module UserPanel
  class UserMailerPreview < ActionMailer::Preview
    def failed_login_attempt
      UserMailer.with(user: User.last).failed_login_attempt
    end
  end
end
