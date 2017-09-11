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
			                                 status: clean_string(td[0].text),
			                                 place: '')
		end
		additional_information(provider_address, code)
	end
	
	
	def additional_information(provider_address, code)
		code_row = ShipmentCode.where(code: code).first
		details = nokogiri_html_page(provider_address, code).css('.detailsTable')
		from = details.css('#lblDeparture').text()
		to = details.css('#lblDestination').text()
		json = {'from' => from, 'to' => to}.to_json
		code_row.update(additional_shipment_info: json)
	end
	
	
	def clean_string(string)
		string.squish.gsub(/<p>[\s$]*<\/p>/, '').strip
	end
end