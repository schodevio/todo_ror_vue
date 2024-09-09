# frozen_string_literal: true

class Checklist < ApplicationRecord
  ## Associations
  belongs_to :user

  ulid :user_id

  ## Validations
  validates :name, presence: true

  def thumbnail_url
    "https://picsum.photos/1280/960?random=#{rand(1000)}"
  end
end
