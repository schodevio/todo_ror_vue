# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { 'Sample Task' }
    description { 'Lorem ipsum' }
    sequence(:position) { _1 }
    completed { false }
    checklist { nil }

    trait :with_checklist do
      checklist
    end
  end
end
