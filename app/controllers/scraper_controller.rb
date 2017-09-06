class ScraperController < ApplicationController
	
	
	def show_form
		@providers = Provider.all.order('id')
	end
	
	
	def store
		user = User.find_or_create_by!(email: user_params['email'])
		provider = Provider.find_by_name(user_params['provider'])
		shipment_code = user_params['code']
		code = ShipmentCode.find_or_create_by!(user_id: user.id,
		                                       provider_id: provider.id,
		                                       code: shipment_code)
		noko = NokogiriScrape.new
		noko.scrape_into_db(provider.address, shipment_code, code.id)
		redirect_to '/'
	end
	
	
	private
	def user_params
		params.require(:user).permit(:email, :code, :provider)
	end
end
