# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Checklists::ProgressPieChartRenderer do
  describe '#call' do
    it 'generates Pie chart with correct data' do
      checklist = create(:checklist, :with_user, name: 'Sample Checklist')
      create_list(:task, 2, checklist: checklist, completed: false)
      create_list(:task, 3, checklist: checklist, completed: true)

      chart = instance_double(Gruff::Pie)
      allow(Gruff::Pie).to receive(:new).and_return(chart)

      allow(chart).to receive(:title=)
      allow(chart).to receive(:theme=)
      allow(chart).to receive(:data)
      allow(chart).to receive(:to_image)

      described_class.call(checklist)

      expect(chart).to have_received(:title=).with("#{checklist.name} - Progress").once
      expect(chart).to have_received(:theme=).with(Gruff::Themes::PASTEL).once
      expect(chart).to have_received(:data).with(:ToDo, 2).once
      expect(chart).to have_received(:data).with(:Completed, 3).once
      expect(chart).to have_received(:to_image).once
    end
  end
end
