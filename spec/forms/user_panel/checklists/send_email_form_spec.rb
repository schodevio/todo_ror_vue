# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::Checklists::SendEmailForm do
  describe '#valid?' do
    context 'with happy path' do
      it 'returns true' do
        checklist = create(:checklist, :with_user)

        params = {
          receiver_email: 'john@example.com',
          user: checklist.user
        }

        form = described_class.new(checklist, params: params)

        expect(form.valid?).to be(true)
        expect(form.errors).to be_empty
      end
    end

    context 'when receiver_email is blank' do
      it 'returns false and produce errors' do
        checklist = create(:checklist, :with_user)

        params = {
          receiver_email: '',
          user: checklist.user
        }

        form = described_class.new(checklist, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:receiver_email]).to contain_exactly("can't be blank")
      end
    end

    context 'when receiver_email has wrong format' do
      it 'returns false and produce errors' do
        checklist = create(:checklist, :with_user)

        params = {
          receiver_email: 'wrong-email',
          user: checklist.user
        }

        form = described_class.new(checklist, params: params)

        expect(form.valid?).to be(false)
        expect(form.errors[:receiver_email]).to contain_exactly('is invalid')
      end
    end
  end

  describe '#call' do
    it 'enqueues UserPanel::ChecklistMailer#checklist_export' do
      checklist = create(:checklist, :with_user)

      params = {
        receiver_email: 'john@example.com',
        user: checklist.user
      }

      action = -> { described_class.new(checklist, params: params).call }

      expect(&action).to have_enqueued_mail(UserPanel::ChecklistMailer, :checklist_export)
    end
  end
end
