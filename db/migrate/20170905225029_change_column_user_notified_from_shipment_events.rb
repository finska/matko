class ChangeColumnUserNotifiedFromShipmentEvents < ActiveRecord::Migration[5.1]
  def change
    change_column :shipment_events, :user_notified, :boolean, default: false
  end
end
