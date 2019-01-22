class User < ActiveRecord::Base
	has_many :characters
	has_many :guilds, through: :characters

	def create_champ(name)
		champ = Character.new(name: name, hp: rand(20..100), atk: rand(1..10), def: rand(1..10), user_id: self.id)
		champ.save
		champ
	end
end
