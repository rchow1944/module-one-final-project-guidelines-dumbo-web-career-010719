class CreateCharacters < ActiveRecord::Migration[4.2]
	def change
		create_table :characters do |t|
			t.string :name
			t.integer :hp
			t.integer :atk
			t.integer :def
			t.integer :user_id
			t.integer :guild_id
		end
	end
end