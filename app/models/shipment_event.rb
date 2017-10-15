class ShipmentEvent < ApplicationRecord
  belongs_to :shipment_code
	belongs_to :company
end
