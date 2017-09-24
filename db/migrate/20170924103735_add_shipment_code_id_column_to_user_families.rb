class AddShipmentCodeIdColumnToUserFamilies < ActiveRecord::Migration[5.1]
	def change
		add_column :user_families, :shipment_code_id, :integer, index: true, foreign_key: true
	end
end
