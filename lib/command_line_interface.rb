def welcome
  puts "Welcome!"
end

def get_user_name
  puts "Please enter your username:"
  user = STDIN.gets.chomp
end

def display_user_characters(user)
  puts "Hello, #{user}"
end
