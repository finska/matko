class AddCompanyIdColumnToShipmentCodes < ActiveRecord::Migration[5.1]
  def change
    add_column :shipment_codes, :company_id, :integer, index: true
  end
end
