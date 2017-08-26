class CreateShipments < ActiveRecord::Migration[5.1]
  def change
    create_table :shipments do |t|
      t.integer :user_id
      t.string :code

      t.timestamps
    end
  end
end
