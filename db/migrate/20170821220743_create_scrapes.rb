class CreateScrapes < ActiveRecord::Migration[5.1]
  def change
    create_table :scrapes do |t|
      t.integer :code_id
      t.datetime :time
      t.text :status
      t.text :place
      t.timestamps
    end
  end
end
