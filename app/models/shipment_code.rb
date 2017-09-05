class ShipmentCode < ApplicationRecord
  belongs_to :user
  has_many :shipment_events
end
