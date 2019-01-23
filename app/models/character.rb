class Character < ActiveRecord::Base
	belongs_to :guild
	belongs_to :user

	def name=(value)
	    super(value)
	    self.save
	end

	def remove_character
		puts "#{self.name} left the game."
    self.user.characters.delete(self)
		self.delete
    Guild.check_member_count
	end

	def update_and_notify(old_value, new_value)
		self.guild_id = new_value.id
		self.save
		if old_value.nil?
			puts "#{self.name} joined the #{self.guild.name} guild."
		else
			puts "#{self.name} updated guild affiliation from #{old_value.name} to #{self.guild.name}."
		end
	end

	def join_guild
		puts "Select from list or create your own."
		Guild.all.each do |guild|
			puts "#{guild.id} - #{guild.name}"
		end
		if self.guild
			last_guild = self.guild
			puts "Current guild: #{last_guild.name}"
		end
		input = STDIN.gets.strip
		if input.count("a-zA-Z") > 0	#check if input is a string (includes letters)
			found = Guild.all.find {|guild| guild.name == input}
			if found && self.guild_id != found.id
				update_and_notify(last_guild, found)
			elsif !found
				return create_guild(input)
			else
				puts "You are already a member of this guild."
			end
		elsif Integer(input)
			found = Guild.all.find_by_id(input)
			if found && self.guild_id != found.id
				update_and_notify(last_guild, found)
			elsif !found
				puts "That guild ID Number doesn't exist! Choose another."
				return join_guild
			else
				puts "You are already a member of this guild."
			end
		end
		Guild.check_member_count
		Guild.list_member_count
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

	def leave_guild
    # binding.pry
    if self.guild
		    puts "#{self.name} left #{self.guild.name}."
    else
        return puts "#{self.name} is unaffiliated."
    end
		self.guild_id = nil
		self.save
		Guild.check_member_count
		Guild.list_member_count
	end
end
