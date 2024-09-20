# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable,
         :validatable

  has_one_time_password after_column_name: :last_otp_at, one_time_backup_codes: true

  encrypts :otp_secret_key, :otp_backup_codes
  serialize :otp_backup_codes, coder: JSON

  ## Associations
  has_many :checklists, dependent: :destroy

  ## Validations
  validates :first_name, :last_name, presence: true
  validates :password, strong_password: true

  def otp_auth_url
    issuer = Rails.application.credentials.fetch(:otp_issuer_name, 'ToDo App User')

    provisioning_uri(email, issuer: issuer)
  end

  def otp_verified?(session_otp_user_id)
    session_otp_user_id.present? && session_otp_user_id == id
  end
end
