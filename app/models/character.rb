class Character < ActiveRecord::Base
	belongs_to :guild
	belongs_to :user

	def join_guild
		puts "Select from List"
		Guild.all.each do |guild|
			puts "#{guild.id} - #{guild.name}"
		end
		input = STDIN.gets.strip
		if input.to_i == 0
			found = Guild.all.find {|guild| guild.name == input}
			if found
				self.guild_id = found.id
				self.save
				puts "#{self.name} updated guild affiliation."
				self
			else
				create_guild(input)
				puts "#{self.name} created the #{input} guild & updated affiliation."
				self
			end
		elsif Integer(input)
			found = Guild.all.find_by_id(input)
			if found
				self.guild_id = input.to_i
				self.save
				puts "#{self.name} updated guild affiliation."
				self
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
			puts "That guild name already exists! Choose another."
		end
	end
end
