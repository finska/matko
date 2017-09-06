require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Matko
	class Application < Rails::Application
		# Initialize configuration defaults for originally generated Rails version.
		config.load_defaults 5.1
		require './app/matko/nokogiri_scrape'
		require './app/matko/providers/db_schenker'
		require './app/matko/providers/matkahuolto'
	end
end
