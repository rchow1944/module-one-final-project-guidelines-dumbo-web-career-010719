def welcome

puts "  (`\\ .-') /`   ('-.                                  _   .-')       ('-. "
puts "   `.( OO ),' _(  OO)                                ( '.( OO )\_   _(  OO)"
puts ",--./  .--.  (,------.,--.       .-----.  .-'),-----. ,--.   ,--.)(,------."
puts "|      |  |   |  .---'|  |.-')  '  .--./ ( OO'  .-.  '|   `.'   |  |  .---'"
puts "|  |   |  |,  |  |    |  | OO ) |  |('-. /   |  | |  ||         |  |  |    "
puts "|  |.'.|  |_)(|  '--. |  |`-' |/_) |OO  )\\_) |  | |  ||  |'.'|  | (|  '--. "
puts "|         |   |  .--'(|  '---.'||  |`-'|   \\ |  | |  ||  |   |  |  |  .--' "
puts Rainbow("|   ,'.   |   |  `---.|      |").color("#cd3232") + Rainbow("(_'  '--'\\    `'  '-'  '|  |   |  |  |  `---.").color("#cd3232")
puts Rainbow("'--'   '--'   `------'`------'   `-----'      `-----' `--'   `--'  `------'").color("#cd3232")

end

def get_user_name(prompt)
  prompt.ask(Rainbow("Please enter your username:").teal) do |q|
    q.required true
    q.modify :trim
    q.messages[:required?] = Rainbow("No username provided").red
  end
end

#Returns user instance from db or creates one if it doesn't exist
def get_user_from_db(prompt, user)
  user_from_db = User.find_or_create_by(name: user)
  if user_from_db.characters.count <= 0
    create_chracter_prompt(prompt, user_from_db)
  end
  user_from_db
end

#Create character
def create_chracter_prompt(prompt, user)
  char_name = prompt.ask(Rainbow("What is your character's name?").teal) do |q|
    q.required true
    q.messages[:required?] = Rainbow("Please enter a name").red
  end
  user.create_champ(char_name)
end

#Displays a list of characters to choose from
def select_user_character(prompt, user)
  choices = user.characters.map {|c|
    {
      name: c.name,
      value: c
    }
  }
  prompt.select(Rainbow("Select a character:").teal, choices, cycle: true)
end

#Displays character information
def display_character_info(character)
  table = Terminal::Table.new :title => Rainbow(character.name).color("#1464dc").bright do |t|
    t.add_row [Rainbow("Health").crimson, character.hp]
    t << :separator
    t.add_row [Rainbow("Attack").color("#3cdc14"), character.atk]
    t << :separator
    t.add_row [Rainbow("Defense").orange, character.def]
  end
  puts table
end

#Selects what to do with character
def select_character_action(prompt, character)
  prompt.select(Rainbow("What do you want to do?").teal) do |menu|
    menu.enum '.'

    menu.choice 'Join Guild', 1
    menu.choice 'Leave Guild', 2
    menu.choice 'Delete Character', 3
  end
end

#Executes chracter action
def run_character_action(selection)

end

#Runs the program
def run(prompt, user)
  found_user = get_user_from_db(prompt, user)
  selected_char = select_user_character(prompt, found_user)
  display_character_info(selected_char)
  selected_action = select_character_action(prompt, selected_char)
end
