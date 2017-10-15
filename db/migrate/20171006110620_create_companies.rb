class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :code
      t.string :name
      t.string :host

      t.timestamps
    end
  end
end
