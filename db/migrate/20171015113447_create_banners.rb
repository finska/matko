class CreateBanners < ActiveRecord::Migration[5.1]
	def change
		create_table :banners do |t|
			t.belongs_to :company, index: true, foreign_key: true
			t.string :image
			t.string :link
			t.boolean :status
			t.datetime :active_from
			t.datetime :active_to
			
			t.timestamps
		end
	end
end
