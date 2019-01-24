class Guild < ActiveRecord::Base
	has_many :characters
	has_many :users, through: :characters

	def owner
		self.characters.first
	end

	def remove_guild
		self.characters.each do |character|
			puts Rainbow("#{character.name} ejected from #{self.name}.").green
			character.guild_id = nil
			character.save
		end
		# super
    self.destroy
		Rainbow("#{self.name} guild has been DESTROYED!").red
	end

	def members_count
		self.characters.count
	end

	def users_count
		self.users.uniq.count
	end

	def self.check_member_count
		Guild.all.each do |guild|
			if guild.members_count == 0
				placeholder = guild.name
				guild.remove_guild
				puts Rainbow("#{placeholder} deleted from guild registry.").red
			end
		end
	end

	def self.list_member_count
		Guild.all.each do |guild|
			puts Rainbow("#{guild.name} has #{guild.members_count} member(s). ").gold
		end
		Rainbow("Updated Guilds list and members count.").green
	end

  #Displays Guild Info
  def display_guild
    table = Terminal::Table.new :title => Rainbow(self.name).color("#1464dc").bright do |t|
      t.add_row [Rainbow("Members").crimson, self.members_count]
    end
    puts table
  end
end
