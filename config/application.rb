require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HoneycombRailsFullstackTracing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    require 'middleware/honeycomb_tracing_middleware'
    config.middleware.insert_before Rack::Head, HoneycombTracingMiddleware

    # This is not secure! In a real app you would not set this
    config.action_controller.permit_all_parameters = true
  end
end
