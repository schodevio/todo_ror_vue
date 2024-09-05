# frozen_string_literal: true

class StrongPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    return if value.match?(/(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^[:alnum:]])/)

    record.errors.add(attribute, options[:message].presence || :weak_password)
  end
end
