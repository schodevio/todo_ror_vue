# frozen_string_literal: true

module UserPanel
  module Checklists
    class SendEmailForm
      include ActiveModel::Model

      attr_reader :checklist, :params
      attr_accessor :receiver_email, :user

      validates :receiver_email, presence: true
      validates :receiver_email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }

      def initialize(checklist, params:)
        @checklist = checklist
        @params = params

        super(params)
      end

      def call
        return false unless valid?

        ChecklistMailer.with(checklist: checklist, user: user).checklist_export.deliver_later
      end
    end
  end
end
