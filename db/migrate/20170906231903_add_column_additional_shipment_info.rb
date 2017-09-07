class AddColumnAdditionalShipmentInfo < ActiveRecord::Migration[5.1]
	def change
		add_column :shipment_codes, :additional_shipment_info, :text
	end
end
