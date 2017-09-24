class UserFamily < ApplicationRecord
  belongs_to :user
	belongs_to :shipment_code
end
