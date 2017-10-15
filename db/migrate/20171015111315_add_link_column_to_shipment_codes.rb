class AddLinkColumnToShipmentCodes < ActiveRecord::Migration[5.1]
  def change
	  add_column :shipment_codes, :link, :string
  end
end
