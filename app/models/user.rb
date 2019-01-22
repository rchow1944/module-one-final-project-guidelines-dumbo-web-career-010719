class User < ActiveRecord::Base
  has_many :characters
  has_many :guilds, through: :characters
end
