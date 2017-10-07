class AddCompanyIdColumnToShipmentEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :shipment_events, :company_id, :integer, index: true
  end
end
