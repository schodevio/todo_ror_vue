# frozen_string_literal: true

class Task < ApplicationRecord
  ## Associations
  belongs_to :checklist

  ulid :checklist_id

  ## Validations
  validates :name, presence: true

  ## Position
  positioned on: :checklist
end
