require_relative '../config/environment'
# require_relative '../lib/command_line_interface.rb'
# require_relative '../app/models/guild.rb'

welcome
prompt = TTY::Prompt.new
user_name = get_user_name(prompt)
user = get_user_from_db(user_name)
run(user)
