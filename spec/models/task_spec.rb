# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:checklist) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
