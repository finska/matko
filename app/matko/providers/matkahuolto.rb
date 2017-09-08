require 'open-uri'
require 'nokogiri'

class Matkahuolto
	
	
	def nokogiri_html_page(provider_address, code)
		Nokogiri::HTML(open("#{provider_address}#{code}"))
	end
	
	
	def events_table_tbody_info(provider_address, code)
		nokogiri_html_page(provider_address, code)
			.css('.events-table')
			.css('tbody')
			.css('tr')
	end
	
	
	def scrape_data(provider_address, code, shipment_code_id)
		events_table_tbody_info(provider_address, code).each do |row|
			td = row.css('td')
			ShipmentEvent.find_or_create_by!(shipment_code_id: shipment_code_id,
			                                 time: td[0].inner_html.to_datetime,
			                                 status: clean_string(td[1].inner_html),
			                                 place: clean_string(td[2].inner_html))
		end
	end
	
	
	def shipping_state
	
	end
	
	
	def clean_string(string)
		string.squish.gsub(/<p>[\s$]*<\/p>/, '').strip
	end
end