class CreateShipmentEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :shipment_events do |t|
      t.belongs_to :shipment_code, index: true, foreign_key: true
      t.datetime :time
      t.text :status
      t.text :place
      t.boolean :user_notified
      t.timestamps
    end
  end
end
