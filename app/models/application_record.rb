# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include ULID::Rails

  primary_abstract_class
  ulid :id, auto_generate: true
end
