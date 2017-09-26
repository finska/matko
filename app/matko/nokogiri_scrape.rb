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
		# send_email(shipment_code_id)
	end
	
	
	def scrape_only(provider_address, code)
		instance = provider_instance(provider_address)
		instance.scrape_info(provider_address,
		                     code)
	end
	
	
	def send_email(shipment_code_id, email)
		if email_not_sent(shipment_code_id)
			events = ShipmentEvent.where(shipment_code_id: shipment_code_id).order(time: :desc)
			events.each do |row|
				row.update(user_notified: true)
			end
			UserMailer.scrape_info(email, events).deliver
		end
	end
	
	
	def check_all_shipments
		if ShipmentCode.exists?
			shipment_codes = ShipmentCode.all
			shipment_codes.each do |row|
				if summary_shipment_status(row.id) != 'Delivered'
					provider = Provider.find(row.provider_id)
					scrape_into_db(provider.address, row.code, row.id)
					user = User.find(row.user_id)
					family = UserFamily.where(user_id: row.user_id).first
					if email_not_sent(row.id)
						events = ShipmentEvent.where(shipment_code_id: row.id).order(time: :desc)
						events.each do |event|
							event.update(user_notified: true)
						end
						UserMailer.scrape_info(user.email, events).deliver
						UserMailer.scrape_info(family.email, events).deliver
					end
				end
			end
		end
	end
	
	
	def email_not_sent(shipment_code_id)
		(ShipmentEvent.exists?(shipment_code_id: shipment_code_id,
		                       user_notified: false)) ? true : false
	end
	
	
	def summary_shipment_status(shipment_code_id)
		if ShipmentEvent.exists?(shipment_code_id: shipment_code_id)
			last_event_status = ShipmentEvent
				.where(shipment_code_id: shipment_code_id)
				.order(time: :asc)
				.last.status
			status_states.each do |key, value|
				value.detect {|val| return (key.capitalize) if val == last_event_status}
			end
		end
	end
	
	
	def status_states
		{'not sent' => ['Electronic advance notice received', 'Received for carriage', 'Luettu terminaalissa'],
		 'transit' => ['En route', 'Saapunut terminaaliin'],
		 'waiting pickup' => ['Ready to be collected', 'Recipient notified by SMS', 'Vastaanotettu noutopisteessä'],
		 'delivered' => ['Handed over to the recipient', 'Asiakas noutanut']}
	end
end