class Code < ApplicationRecord
  belongs_to :user
  has_many :scrapes
end
