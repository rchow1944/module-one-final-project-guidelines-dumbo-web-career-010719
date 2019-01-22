def welcome
  puts "Welcome!"
end

def get_user_name
  puts "Please enter your username:"
  user = STDIN.gets.chomp
end

def display_user_characters(user)
  found_user = User.find_or_create_by(name: user)
  found_user.characters.each_with_index { |character, i|
    puts "#{i+1}. #{character.name}"
  }
end
