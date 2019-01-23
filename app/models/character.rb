class Character < ActiveRecord::Base
	belongs_to :guild
	belongs_to :user

	def join_guild
		puts "Select from list or create your own."
		Guild.all.each do |guild|
			puts "#{guild.id} - #{guild.name}"
		end
		if self.guild
			last_guild = self.guild
		end
		p "Current guild: #{last_guild.name}"

		input = STDIN.gets.strip
		if input.count("a-zA-Z") > 0	#check if input is a string (includes letters)
			found = Guild.all.find {|guild| guild.name == input}
			if found && self.guild_id != found.id
				self.guild_id = found.id
				self.save
				if last_guild.nil?
					puts "#{self.name} updated guild affiliation to #{self.guild.name}."
				else
					puts "#{self.name} updated guild affiliation from #{last_guild.name} to #{self.guild.name}."
				end
			elsif !found
				create_guild(input)
			else
				puts "You are already a member of this guild."
			end
		elsif Integer(input)
			found = Guild.all.find_by_id(input)
			if found && self.guild_id != input.to_i
				self.guild_id = input.to_i
				self.save
				p "New guild: #{self.guild.name}"

				if last_guild.nil?
					puts "#{self.name} updated guild affiliation to #{self.guild.name}."
				else
					puts "#{self.name} updated guild affiliation from #{last_guild.name} to #{self.guild.name}."
				end
			elsif !found
				puts "That guild ID Number doesn't exist! Choose another."
				join_guild
			else
				puts "You are already a member of this guild."
			end
		end
		Guild.check_member_count
		Guild.all.each do |guild|
			print "#{guild.name} has #{guild.members_count} member(s). "
		end
		return "Updated Guilds list and members count."
	end

	def create_guild(name)
		found = Guild.all.find {|guild| guild.name == name}
		if !found
			new_guild = Guild.create(name: name)
			self.guild_id = new_guild.id
			self.save
			puts "#{self.name} created the #{name} guild & updated affiliation."
		else
			puts "That guild name already exists! Choose another."
		end
		Guild.check_member_count
		"Guilds list updated."
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
