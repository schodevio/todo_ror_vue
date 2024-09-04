# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StrongPasswordValidator do
  subject(:mocked_class) do
    Class.new do
      include ActiveModel::Validations

      attr_accessor :password

      validates :password, strong_password: true

      def self.name
        'Test'
      end
    end
  end

  context 'when regexp is satisfied' do
    it 'is valid' do
      record = mocked_class.new
      record.password = 'Password123!'

      expect(record).to be_valid
    end
  end

  context 'when uppercase letter is missing' do
    it 'is not valid' do
      record = mocked_class.new
      record.password = 'password123!'

      expect(record).not_to be_valid

      expect(record.errors[:password])
        .to contain_exactly(a_string_matching(/must contain at least/))
    end
  end

  context 'when lowercase letter is missing' do
    it 'is not valid' do
      record = mocked_class.new
      record.password = 'PASSWORD123!'

      expect(record).not_to be_valid

      expect(record.errors[:password])
        .to contain_exactly(a_string_matching(/must contain at least/))
    end
  end

  context 'when digit is missing' do
    it 'is not valid' do
      record = mocked_class.new
      record.password = 'Password!'

      expect(record).not_to be_valid

      expect(record.errors[:password])
        .to contain_exactly(a_string_matching(/must contain at least/))
    end
  end

  context 'when special character is missing' do
    it 'is not valid' do
      record = mocked_class.new
      record.password = 'Password123'

      expect(record).not_to be_valid

      expect(record.errors[:password])
        .to contain_exactly(a_string_matching(/must contain at least/))
    end
  end
end
