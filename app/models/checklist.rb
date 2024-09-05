# frozen_string_literal: true

class Checklist < ApplicationRecord
  ## Associations
  belongs_to :user

  ulid :user_id

  ## Validations
  validates :name, presence: true
end
