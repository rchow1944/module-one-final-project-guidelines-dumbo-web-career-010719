class User < ActiveRecord::Base
	has_many :characters
	has_many :guilds, through: :characters

	def create_champ(name)
		champ = Character.find_or_create_by(name: name, user_id: self.id) do |champ|
       champ.hp = rand(20..100)
       champ.atk = rand(1..10)
       champ.def = rand(1..10)
       end
		champ
	end
end
