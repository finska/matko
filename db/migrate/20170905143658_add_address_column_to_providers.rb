class AddAddressColumnToProviders < ActiveRecord::Migration[5.1]
  def change
    add_column :providers, :address, :text
  end
end
