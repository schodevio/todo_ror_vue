# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Checklists::ExportPresenter do
  describe '#filename' do
    it 'containe checklist name and current timestamp' do
      travel_to Time.new(2024, 9, 1, 16, 30, 15, 'UTC')

      checklist = create(:checklist, :with_user, name: 'Sample Checklist')

      presenter = described_class.new(checklist, user: checklist.user)

      expect(presenter.filename).to eq('sample_checklist_20240901T163015Z.pdf')
    end
  end

  describe '#as_pdf' do
    it 'calls RenderPDFService with checklist_export as views' do
      checklist = create(:checklist, :with_user, name: 'Sample Checklist')

      allow(RenderPDFService).to receive(:call)

      presenter = described_class.new(checklist, user: checklist.user)
      presenter.as_pdf

      expect(RenderPDFService)
        .to have_received(:call)
        .with(presenter, views: 'pdfs/checklist_export')
    end
  end
end
