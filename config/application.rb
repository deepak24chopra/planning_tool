require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlanningTool
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.delete Rack::Sendfile
    config.middleware.delete Rack::MethodOverride
    config.middleware.delete Rack::Head
    config.middleware.delete Rack::ETag
    config.middleware.delete Rack::Runtime
    config.middleware.delete ActionDispatch::Flash
    config.middleware.delete ActionDispatch::Executor
    config.middleware.delete ActionDispatch::RequestId
    config.middleware.delete Rails::Rack::Logger
    config.middleware.delete ActionDispatch::ShowExceptions
    config.middleware.delete ActionDispatch::DebugExceptions
    config.middleware.delete ActionDispatch::RemoteIp
    config.middleware.delete ActionDispatch::Reloader
    config.middleware.delete ActionDispatch::Callbacks
    config.middleware.delete ActiveRecord::Migration::CheckPending
    
  end
end
