class Company < ApplicationRecord
	has_many :users
	has_many :shipment_codes
	has_many :shipment_events
end
