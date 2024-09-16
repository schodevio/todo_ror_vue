# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'ulid/rails'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TodoRorVue
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Eager load paths
    config.eager_load_paths << Rails.root.join('app', 'concerns')
    config.eager_load_paths << Rails.root.join('app', 'forms')
    config.eager_load_paths << Rails.root.join('app', 'presenters')
    config.eager_load_paths << Rails.root.join('app', 'services')
    config.eager_load_paths << Rails.root.join('app', 'validators')

    # Generators
    config.generators do |g|
      g.factory_bot suffix: 'factory'
      g.test_framework :rspec
    end
  end
end
