class User < ActiveRecord::Base
	has_many :characters
	has_many :guilds, through: :characters

	def create_champ(name)
		champ = Character.new(name: name, hp: rand(20..100), atk: rand(1..10), def: rand(1..10), user_id: self.id)
		champ.save
		champ
	end

  	#Displays characters for user
  	def display_user_characters
	    self.characters.each_with_index { |character, i|
	      puts "#{i+1}. #{character.name}"
	    }
  	end

end
