class User < ApplicationRecord
  has_many :user_families
  has_many :shipment_codes
end
