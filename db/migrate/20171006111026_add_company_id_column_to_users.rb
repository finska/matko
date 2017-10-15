class AddCompanyIdColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :company_id, :integer, index: true
  end
end
