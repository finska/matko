require_relative '../../app/matko/nokogiri_scrape.rb'
namespace :shipment do
  desc('Check if there any changes in shipments')
  task schedule: :environment do
	  nok = NokogiriScrape.new
    nok.check_all_shipments
  end
end