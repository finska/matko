class ApplicationController < ActionController::Base
	
	
	def current_user
		{'email' => 'zeljko@z-ware.fi', 'company' => {'name' => 'Retkitukku', 'code' => 'rt'}}
	end
	
	
	def current_company
		{'name' => 'Retkitukku', 'code' => 'rt'}
	end
	
	
	# send address /shipments parameters tracking_code, provider, link
	def shipments_request
		code = params[:tracking_code]
		provider = params[:provider]
		link = params[:link]
		email = email_from_uri(link)
		company_code = company_code_from_uri(link)
		company = Company.find_or_create_by!(code: company_code, host: link, name: 'Retkitukku')
		user = User.find_or_create_by!(email: email, company_id: company.id)
		provider = Provider.find_by_name(provider)
		ShipmentCode.find_or_create_by!(user_id: user.id, provider_id: provider.id, code: code, company_id: company.id, link: link)
	end
	
	
	def email_from_uri(uri)
		URI.parse(uri).path().split('/')[1]
	end
	
	
	def company_code_from_uri(uri)
		URI.parse(uri).path().split('/')[3]
	end
end
