# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::ChecklistMailer, type: :mailer do
  describe 'checklist_export' do
    it 'defines mail' do
      user = create(:user, email: 'john@example.com')
      checklist = create(:checklist, user: user, name: 'Sample Name')
      create_list(:task, 2, checklist: checklist)

      mail = described_class.with(checklist: checklist, user: user).checklist_export

      expect(mail.to).to contain_exactly(user.email)
      expect(mail.subject).to eq "[App Name] Checklist: #{checklist.name}"
      expect(mail.attachments.size).to eq(1)
    end
  end
end
