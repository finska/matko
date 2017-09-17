class ScraperController < ApplicationController
	
	
	def show_form
		@providers = Provider.all.order('id')
		if flash[:code_id]
			
			@shipment_code = ShipmentCode.find(flash[:code_id])
			@shipment_events = ShipmentEvent.where(shipment_code_id: @shipment_code.id)
			@notified = @shipment_events.where(user_notified: false)
		end
	end
	
	
	def store
		if user_params['email'].blank? and user_params['code'].blank?
			flash[:warning] = 'You cannot send blank fields!'
			redirect_to '/'
		# elsif ShipmentCode.exists?(code: user_params['code'])
		# 	flash[:warning] = 'We already have that code associated with another mail!'
		# 	redirect_to '/'
		else
			user = User.find_or_create_by!(email: user_params['email'])
			provider = Provider.find_by_name(user_params['provider'])
			shipment_code = user_params['code']
			code = ShipmentCode.find_or_create_by!(user_id: user.id,
			                                       provider_id: provider.id,
			                                       code: shipment_code)
			nokogiri_scrape = NokogiriScrape.new
			nokogiri_scrape.scrape_into_db(provider.address,
			                               shipment_code,
			                               code.id)
			flash[:status] = nokogiri_scrape.summary_shipment_status(code.id)
			flash[:code_id] = code.id
			redirect_to '/'
		end
	end
	
	
	def additional_email
		additional_email = additional_email_params['additional_email']
		user_id = additional_email_params['user_id']
		UserFamily.find_or_create_by!(user_id: user_id, email: additional_email)
	end
	
	
	private
	def user_params
		params.require(:user).permit(:email, :code, :provider, :additional_email)
	end
	
	
	private
	def additional_email_params
		params.require(:email).permit(:user_id, :additional_email)
	end
end
