require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
#require "active_resource/railtie"
require "rails/test_unit/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Timecert
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.session_store :disabled
    # Yes I know this looks bad, but we aren't actually using sessions see above line. Rails complains if it isn't there
    config.secret_token = "some secret phrase of at least 30 characters"
    # Add additional load paths for your own custom dirs
    #  config.autoload_paths += %W( #{config.root}/app/errors #{config.root}/lib )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.middleware.use Rack::Deflater
    
    [ Rack::Lock, ActionDispatch::Cookies, ActionDispatch::Session::CookieStore, ActionDispatch::Flash].each do |m|
      config.middleware.delete(m)
    end
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.template_engine :haml
      g.stylesheets     false
      g.test_framework  :rspec, :helper_specs=>false, :controller_specs=>false, :view_specs=>false
      g.fixture_replacement :machinist
    end

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password
    
  end
end
