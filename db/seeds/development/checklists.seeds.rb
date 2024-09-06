# frozen_string_literal: true

user = User.find_by(email: 'john@example.com')

if user
  Date::DAYNAMES.each do |dayname|
    Checklist.find_or_create_by!(name: dayname, user: user)
  end
end
