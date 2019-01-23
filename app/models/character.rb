class Character < ActiveRecord::Base
	belongs_to :guild
	belongs_to :user

	def join_guild
		puts "Select from list or create your own."
		Guild.all.each do |guild|
			puts "#{guild.id} - #{guild.name}"
		end
		last_guild = self.guild
		input = STDIN.gets.strip
		if input.count("a-zA-Z") > 0	#check if input is a string (includes letters)
			found = Guild.all.find {|guild| guild.name == input}
			if found
				self.guild_id = found.id
				self.save
				"#{self.name} updated guild affiliation from #{last_guild.name} to #{self.guild.name}."
			else
				create_guild(input)
				"#{self.name} created the #{input} guild & updated affiliation."
			end
		elsif Integer(input)
			found = Guild.all.find_by_id(input)
			if found
				self.guild_id = input.to_i
				self.save
				"#{self.name} updated guild affiliation from #{last_guild.name} to #{self.guild.name}."
			else
				puts "That guild ID Number doesn't exist! Choose another."
				join_guild
			end
		end
	end

	def create_guild(name)
		found = Guild.all.find {|guild| guild.name == name}
		if !found
			new_guild = Guild.create(name: name)
			self.guild_id = new_guild.id
			self.save
		else
			"That guild name already exists! Choose another."
		end
	end

  	#Displays character info
  	def display_info
	    # selected_char = user.characters[selection-1]
	    puts "Name: #{self.name}"
	    puts "Guild: #{self.guild.name}"
	    puts "Health: #{self.hp}"
	    puts "Attack: #{self.atk}"
	    puts "Defense: #{self.def}"
  	end
end
