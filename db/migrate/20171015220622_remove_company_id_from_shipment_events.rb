class RemoveCompanyIdFromShipmentEvents < ActiveRecord::Migration[5.1]
  def change
	  remove_column :shipment_events, :company_id
  end
end
