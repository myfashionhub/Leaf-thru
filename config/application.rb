require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Leafthru
  class Application < Rails::Application
    config.autoload_paths += %W( lib/ )
    config.assets.precompile += %w( welcome.js )
    config.assets.precompile += %w( articles.js )
    config.assets.precompile += %w(*.svg)
  end
end
