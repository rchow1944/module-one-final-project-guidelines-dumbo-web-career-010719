class Character < ActiveRecord::Base
	belongs_to :guild
	belongs_to :user

	def name=(value)
	    super(value)
	    self.save
	end

	def remove_character
		puts Rainbow("#{self.name} left the game.").green
    # self.user.characters.delete(self)
		self.destroy
    Guild.check_member_count
	end

	def update_and_notify(old_value, new_value)
		self.guild_id = new_value.id
		self.save
		if old_value.nil?
			puts Rainbow("#{self.name} joined the #{self.guild.name} guild.").green
		else
			puts Rainbow("#{self.name} updated guild affiliation from #{old_value.name} to #{self.guild.name}.").green
		end
	end

	def join_guild
		puts Rainbow("Select from list or create your own.").teal
		Guild.all.each do |guild|
			puts Rainbow("#{guild.id} - #{guild.name}").gold
		end
		if self.guild
			last_guild = self.guild
			puts Rainbow("Current guild: #{last_guild.name}").green
		end
		input = STDIN.gets.strip
		if input.count("a-zA-Z") > 0	#check if input is a string (includes letters)
			found = Guild.all.find {|guild| guild.name == input}
			if found && self.guild_id != found.id
				update_and_notify(last_guild, found)
			elsif !found
				return create_guild(input)
			else
				puts Rainbow("You are already a member of this guild.").red
			end
		elsif Integer(input)
			found = Guild.all.find_by_id(input)
			if found && self.guild_id != found.id
				update_and_notify(last_guild, found)
			elsif !found
				puts Rainbow("That guild ID Number doesn't exist! Choose another.").red
				return join_guild
			else
				puts Rainbow("You are already a member of this guild.").red
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
			puts Rainbow("#{self.name} created the #{name} guild & updated affiliation.").green
		else
			puts Rainbow("That guild name already exists! Choose another.").red
		end
		Guild.check_member_count
		Rainbow("Guilds list updated.").green
	end

	def leave_guild
    # binding.pry
    if self.guild
		    puts Rainbow("#{self.name} left #{self.guild.name}.").green
    else
        return puts Rainbow("#{self.name} is unaffiliated.").red
    end
		self.guild_id = nil
		self.save
		Guild.check_member_count
		Guild.list_member_count
	end
end
