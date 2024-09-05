# frozen_string_literal: true

FactoryBot.define do
  factory :checklist do
    name { 'Sample List' }
    user { nil }

    trait :with_user do
      user
    end
  end
end
