# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { SecureRandom.urlsafe_base64(64, true) }
    first_name { 'John' }
    last_name { 'Doe' }
  end
end
