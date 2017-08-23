class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.integer :user_id
      t.string :code
      t.timestamps
    end
  end
end
