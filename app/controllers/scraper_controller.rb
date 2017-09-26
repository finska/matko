class ScraperController < ApplicationController
	
	
	def show_form
		@providers = Provider.all.order('id')
	end
	
	
	def analyze
		if ShipmentCode.exists?(code: params[:code])
			shipment = ShipmentCode.find_by_code(params[:code])
			@user = User.find(shipment.user_id)
			if @user.email != shipment.code
				@primary_email = @user.email
			end
			if UserFamily.exists?(user_id: shipment.user_id)
				@additional_email = UserFamily.find_by_user_id(shipment.user_id)
			end
		else
			@user = User.find_or_create_by!(email: params[:code])
		end
		if Provider.exists?(name: params[:provider])
			provider = Provider.find_by_name(params[:provider])
			shipment_code = params[:code]
			@code = ShipmentCode.find_or_create_by!(user_id: @user.id,
			                                        provider_id: provider.id,
			                                        code: shipment_code)
			nokogiri_scrape = NokogiriScrape.new
			nokogiri_scrape.scrape_into_db(provider.address,
			                               shipment_code,
			                               @code.id)
			if ShipmentEvent.exists?(shipment_code_id: @code.id)
				@shipment_events = ShipmentEvent.where(shipment_code_id: @code.id)
				summary_shipment_status = nokogiri_scrape.summary_shipment_status(@code.id)
				flash[:status] = summary_shipment_status
				flash[:code_id] = @code.id
			else
				ShipmentCode.find_by_code(params[:code]).delete
				User.find_by_email(params[:code]).delete
				flash[:status_first] = 'There is no records for that combination of provider and code! Check that your code is correct!'
				redirect_to '/'
			end
		else
			flash[:status] = 'There is no provider with that name, please choose from dropdown list!'
			redirect_to '/'
		end
	end
	
	
	def store_email
		email = params[:email]
		user = User.find(params[:user_id])
		
		
		user.update(email: email)
		
		nokogiri_scrape = NokogiriScrape.new
		nokogiri_scrape.send_email(params[:shipment_code_id], user.email)
		
		respond_to do |format|
			format.json {render json: {'email_address' => user.email, 'shipment_id' => params[:shipment_code_id]}}
		end
	end
	
	
	def additional_email
		additional_email = params[:email]
		user_id = params[:user_id]
		shipmentCodeId = params[:shipment_code_id]
		UserFamily.find_or_create_by!(user_id: user_id, shipment_code_id: shipmentCodeId, email: additional_email)
		
		events = ShipmentEvent.where(shipment_code_id: shipmentCodeId)
		events.each do |row|
			row.update(user_notified: false)
		end
		
		nokogiri_scrape = NokogiriScrape.new
		nokogiri_scrape.send_email(shipmentCodeId, additional_email)
		
		respond_to do |format|
			format.json {render json: {'add_email' => additional_email}}
		end
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
