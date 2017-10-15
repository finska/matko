class Company < ApplicationRecord
	has_many :shipment_codes
	has_many :banners
end
