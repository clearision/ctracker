require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ctracker
  class Application < Rails::Application
    config.load_defaults 6.0
    config.generators.test_framework :rspec
  end
end
