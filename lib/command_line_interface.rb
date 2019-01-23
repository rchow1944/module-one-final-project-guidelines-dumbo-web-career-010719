def welcome
  puts "Welcome!"
end

def get_user_name(prompt)
  prompt.ask("Please enter your username:") do |q|
    q.required true
    q.modify :trim
    q.messages[:required?] = "No username provided"
  end
end

#Returns user instance from db or creates one if it doesn't exist
def get_user_from_db(user)
  User.find_or_create_by(name: user)
end

#Displays a list of characters to choose from
def select_user_character(prompt, user)
  choices = user.characters.map {|c|
    {
      name: c.name,
      value: c
    }
  }
  prompt.select("Select a character:", choices, cycle: true)
end

#Displays character information
def display_character_info(character)
  table = Terminal::Table.new :title => character.name do |t|
    t.add_row ["Health", character.hp]
    t << :separator
    t.add_row ["Attack", character.atk]
    t << :separator
    t.add_row ["Defense", character.def]
  end
  puts table
end

#Runs the program
def run(prompt, user)
  found_user = get_user_from_db(user)
  selected_char = select_user_character(prompt, found_user)
  display_character_info(selected_char)

end
