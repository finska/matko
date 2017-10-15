class ShipmentCode < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :shipment_events
end
