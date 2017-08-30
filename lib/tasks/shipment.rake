require_relative '../../app/helpers/scraper_helper.rb'
include ScraperHelper
namespace :shipment do
  desc('Check if there any changes in shipments')
  task schedule: :environment do
    ScraperHelper::check_all_shipments
  end
end