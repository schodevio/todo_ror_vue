# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RenderPDFService do
  describe '#call' do
    it 'uses ApplicationController to render header, body and footer of PDF file' do
      checklist = create(:checklist, :with_user, name: 'Sample Checklist')
      presenter = Checklists::ExportPresenter.new(checklist, user: checklist.user)
      views = 'pdfs/checklist_export'

      allow(ApplicationController).to receive(:render).exactly(3).times

      described_class.call(presenter, views: views)

      %w[header body footer].each do |item|
        expect(ApplicationController)
          .to have_received(:render)
          .with hash_including(template: "#{views}/#{item}")
      end
    end
  end
end
