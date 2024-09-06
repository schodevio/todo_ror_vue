# frozen_string_literal: true

RSpec::Matchers.define_negated_matcher :not_change, :change
RSpec::Matchers.define_negated_matcher :not_have_enqueued_mail, :have_enqueued_mail
RSpec::Matchers.define_negated_matcher :not_have_received, :have_received
