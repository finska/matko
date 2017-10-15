class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	
	
	def current_user
		{'email' => "zeljko@z-ware.fi", "company" => {"name" => "Retkitukku", "code" => "rt"}}
	end
	
	
	def current_company
		{"name" => "Retkitukku", "code" => "rt"}
	end
	
	
	def shipments_request
		code = params[:tracking_code]
		provider = params[:provider]
		link = params[:link]
	end
end
