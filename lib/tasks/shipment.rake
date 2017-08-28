require_relative '../../app/helpers/scraper_helper'
namespace :shipment do
  task :schedule do
    include ScraperHelper
    ScraperHelper.check_all_shipments()
  end

end
