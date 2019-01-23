def welcome
  puts "Welcome!"
end

def get_user_name
  puts "Please enter your username:"
  user = STDIN.gets.chomp
end

#Returns user instance from db or creates one if it doesn't exist
def get_user_from_db(user)
  User.find_or_create_by(name: user)
end

#Returns number selected
def select_character
  puts "Select a character by menu number:"
  selection = gets.chomp.to_i - 1
end

#Gets menu selection
def get_character_from_user(user, selection)
  if selection < 1 || selection >= user.characters.count
    puts "The character you selected does not exist!"
  else
    user.characters[selection]
  end
end

#Runs the program
def run(user)
  found_user = get_user_from_db(user)
  found_user.display_user_characters
  selection = select_character
  selected_char = get_character_from_user(found_user, selection)
  if selected_char == nil
    found_user.display_user_characters
    selection = select_character
  else
    selected_char.display_info
  end
end
