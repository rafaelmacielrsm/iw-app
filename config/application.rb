require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IwApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.view_specs    false
      g.helper_specs  false
      g.stylesheets   false
      g.javascripts   false
      g.helper        false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
