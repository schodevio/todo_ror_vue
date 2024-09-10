# frozen_string_literal: true

class Checklist < ApplicationRecord
  ## Associations
  belongs_to :user

  has_one_attached :thumbnail, dependent: :destroy
  has_many :tasks, dependent: :destroy

  ulid :user_id

  ## Validations
  validates :name, presence: true
end
