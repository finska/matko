class TrackLiftController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	
	def read_request
		code = params[:code]
		name = params[:company_name]
		host = params[:company_host]
		
		Company.find_or_create_by!(code: code, name: name, host: host)
	end
	
	
	
end
