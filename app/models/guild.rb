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
end