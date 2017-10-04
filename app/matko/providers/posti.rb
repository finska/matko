require 'open-uri'
require 'nokogiri'

class Posti
	
	
	def nokogiri_html_page(provider_address, code)
		Nokogiri::HTML(open("#{provider_address}#{code}"))
	end
	
	
	def events_table_tbody_info(provider_address, code)
		nokogiri_html_page(provider_address, code)
			.css('.page-menu-list')
			.css('li.page-menu-item')
	end
	
	
	def scrape_data(provider_address, code, shipment_code_id)
		events_table_tbody_info(provider_address, code).each do |row|
			el = row.css('.page-menu-col')
			ShipmentEvent.find_or_create_by!(shipment_code_id: shipment_code_id,
			                                 time: el[2].inner_html.to_datetime,
			                                 status: clean_string(el[0].inner_html),
			                                 place: clean_string(el[3].inner_html))
		end
	end
	
	
	def scrape_info(provider_address, code)
		information = events_table_tbody_info(provider_address, code).map do |row|
			td = row.css('td')
			[td[0].inner_html.to_datetime, clean_string(td[1].inner_html)].to_h
		end
		return information
	end
	
	
	def shipping_state
	
	end
	
	
	def clean_string(string)
		string.squish.gsub(/<p>[\s$]*<\/p>/, '').strip
	end
end