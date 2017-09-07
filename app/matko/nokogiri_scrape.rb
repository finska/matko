class NokogiriScrape
	
	
	def provider_instance(provider_address)
		provider = Provider.find_by_address(provider_address)
		Object.const_get(provider.name.gsub(/\s+/, '')).new
	end
	
	
	def scrape_into_db(provider_address, code, shipment_code_id)
		instance = provider_instance(provider_address)
		instance.scrape_data(provider_address,
		                     code,
		                     shipment_code_id)
		send_email(shipment_code_id)
	end
	
	
	def send_email(shipment_code_id)
		code = ShipmentCode.find(shipment_code_id)
		user = User.find(code.user_id)
		if email_not_sent(shipment_code_id)
			scrape = ShipmentEvent.where(shipment_code_id: shipment_code_id).order(time: :desc)
			scrape.each do |row|
				row.update(user_notified: true)
			end
			UserMailer.scrape_info(user, scrape).deliver
		end
	end
	
	
	def check_all_shipments
		if ShipmentCode.exists?
			shipment_codes = ShipmentCode.all
			shipment_codes.each do |row|
				provider = Provider.find(row.provider_id)
				scrape_into_db(provider.address, row.code, row.id)
				user = User.find(row.user_id)
				if email_not_sent(row.id)
					scrape = ShipmentEvent.where(shipment_code_id: row.id).order(time: :desc)
					scrape.each do |row|
						row.update(user_notified: true)
					end
					UserMailer.scrape_info(user, scrape).deliver
				end
			end
		end
	end
	
	
	def email_not_sent(shipment_code_id)
		(ShipmentEvent.exists?(shipment_code_id: shipment_code_id,
		                       user_notified: false)) ? true : false
	end
end