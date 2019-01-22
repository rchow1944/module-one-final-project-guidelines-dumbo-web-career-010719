require_relative '../config/environment'
# require_relative '../lib/command_line_interface.rb'
# require_relative '../app/models/guild.rb'

welcome
user = get_user_name
display_user_characters(user)
