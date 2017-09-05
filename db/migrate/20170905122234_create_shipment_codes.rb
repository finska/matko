class CreateShipmentCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :shipment_codes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :provider, index: true, foreign_key: true
      t.string :code
      t.timestamps
    end
  end
end
