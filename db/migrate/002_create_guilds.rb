class CreateGuilds < ActiveRecord::Migration[4.2]
	def change
		create_table :guilds do |t|
			t.string :name
		end
	end
end