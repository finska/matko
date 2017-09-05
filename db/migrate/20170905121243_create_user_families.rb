class CreateUserFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :user_families do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :email
    end
  end
end
