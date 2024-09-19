# frozen_string_literal: true

User.find_or_create_by!(email: 'john@example.com') do |user|
  user.assign_attributes(first_name: 'John', last_name: 'Doe', password: 'Password123!')
end
