# frozen_string_literal: true

class Checklist < ApplicationRecord
  ## Associations
  belongs_to :user

  has_one_attached :thumbnail

  ulid :user_id

  ## Validations
  validates :name, presence: true
end
