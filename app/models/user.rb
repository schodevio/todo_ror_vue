# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  ## Associations
  has_many :checklists, dependent: :destroy

  ## Validations
  validates :first_name, :last_name, presence: true
  validates :password, strong_password: true
end
