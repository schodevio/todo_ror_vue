# frozen_string_literal: true

namespace :brakeman do
  desc 'Run Brakeman'

  task run: :environment do
    sh 'brakeman --no-pager'
  end
end
