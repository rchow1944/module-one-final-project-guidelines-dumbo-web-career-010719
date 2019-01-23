class Character < ActiveRecord::Base
	belongs_to :guild
	belongs_to :user

	def join_guild
		puts "Select from List"
		puts Guild.all
		input = STDIN.gets.strip
		if input.to_i == 0
			found = Guild.all.find {|guild| guild.name == input}
			if found
				self.guild_id = found.id
				self.save
			else
				create_guild(input)
			end
		elsif Integer(input)
			self.guild_id = input.to_i
			self.save
		end
	end

	def create_guild(name)
		found = Guild.all.find {|guild| guild.name == name}
		if !found
			new_guild = Guild.create(name: name)
			self.guild_id = new_guild.id
			self.save
		else
			puts "That guild name already exists! Choose another."
		end
	end

  # #Displays character info
  # def display_info
  #   # selected_char = user.characters[selection-1]
  #   puts "Name: #{self.name}"
  #   puts "Guild: #{self.guild.name}"
  #   puts "Health: #{self.hp}"
  #   puts "Attack: #{self.atk}"
  #   puts "Defense: #{self.def}"
  # end
end
