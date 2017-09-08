class ScraperController < ApplicationController
	
	
	def show_form
		@providers = Provider.all.order('id')
		if flash[:code_id]
			shipment_code = ShipmentCode.find(flash[:code_id])
			@shipment_events = ShipmentEvent.where(shipment_code_id: shipment_code.id)
			@notified = @shipment_events.where(user_notified: false)
		end
	end
	
	
	def store
		user = User.find_or_create_by!(email: user_params['email'])
		provider = Provider.find_by_name(user_params['provider'])
		shipment_code = user_params['code']
		code = ShipmentCode.find_or_create_by!(user_id: user.id,
		                                       provider_id: provider.id,
		                                       code: shipment_code)
		NokogiriScrape.new.scrape_into_db(provider.address,
		                                  shipment_code,
		                                  code.id)
		flash[:code_id] = code.id
		redirect_to '/'
	end
	
	
	private
	def user_params
		params.require(:user).permit(:email, :code, :provider)
	end
end
