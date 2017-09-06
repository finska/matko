require 'open-uri'
require 'nokogiri'


class DBSchenker
	
	def nokogiri_html_page(provider_address, code)
		Nokogiri::HTML(open("#{provider_address}#{code}"))
	end
	
	
	def events_table_tbody_info(provider_address, code)
		nokogiri_html_page(provider_address, code)
			.css('#grdActions')
			.css('tr')
	end
	
	
	def scrape_data(provider_address, code, shipment_code_id)
		data = events_table_tbody_info(provider_address, code)
		data.shift
		data.each do |row|
			td = row.css('td')
			time = (td[1].text + ', '+ td[2].text).to_datetime
			ShipmentEvent.find_or_create_by!(shipment_code_id: shipment_code_id,
			                                 time: time,
			                                 status: td[0].text,
			                                 place: '')
		end
	end
	
	
	def shipping_state
	
	end
	
	
	def clean_string(string)
		string.squish.gsub(/<p>[\s$]*<\/p>/, '')
	end
end