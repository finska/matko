class RemoveAndAddColumnsToShipmentEvents < ActiveRecord::Migration[5.1]
	def change
		remove_column :shipment_events, :time
		remove_column :shipment_events, :place
		remove_column :shipment_events, :user_notified
		add_column :shipment_events, :provider, :timestamp
		add_column :shipment_events, :query, :timestamp
		add_column :shipment_events, :details, :text
		add_column :shipment_events, :label, :text
	end
end
