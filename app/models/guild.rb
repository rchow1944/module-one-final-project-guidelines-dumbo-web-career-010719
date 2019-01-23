class Guild < ActiveRecord::Base
	has_many :characters
	has_many :users, through: :characters

	def owner
		self.characters.first
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
				guild.destroy
				puts "#{placeholder} deleted from guild registry."
			end
		end
	end
end
