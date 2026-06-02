# Fiel created 6/1/2026 by Joon Yoo 
require_relative 'game_environment'

# Created 6/1/2026 by Joon Yoo
# Displays the game manual, including card attributes, set rules, controls, and scoring.
def manual
    puts "\n------------"
    puts "|  Manual  |"
    puts "------------"
    puts "\nEach card has four attributes: shape, color, number, and pattern."
    puts "A set is made of three cards."
    puts "For each attribute, the three cards must be either all the same or all different."
    puts "\n- How to play -"
    puts "Enter 3 card numbers to select a set. Example: 1 2 3"
    puts "Enter 'd' to draw 3 more cards. Maximum of 18 cards can be on the board."
    puts "Enter 'q' to quit the game."
    puts "\n- Scoring -"
    puts "If you choose a valid set, 3 points will be awarded."
    puts "If you choose an invalid set, 1 point will be deducted."
end

# Created 6/1/2026 by Joon Yoo
# Handles mode selection, creates a GameEnvironment object, and starts the game.
def enter_game player_id, player_name
    # Displays the game mode options and gets the player's input.
    puts "\nPlease select a game mode"
    puts "1. Tutorial mode"
    puts "2. Singleplayer mode"
    puts "3. Multiplayer mode"
    print "> "
    selected_mode = gets.chomp.strip

    # Sets the game mode based on the player's input.
    #   If the input is invalid, the game starts in singleplayer mode by default.
    mode = case selected_mode
    when "1" then :tutorial
    when "2" then :singleplayer
    when "3" then :multiplayer
    else
        puts "Invalid input. Starting Singleplayer mode by default."
        :singleplayer
    end

    # Create the game environment using the player's information.
    game = GameEnvironment.new(player_id, player_name)

    # Sets the selected game mode and starts the game.
    game.choose_game_mode(mode)
    game.start_game
end

# Displays the welcome message.
puts "---------------------------------"
puts "|  Welcome to the Game of Set!  |"
puts "---------------------------------"

# Gets the player's ID and name before starting the game.
print "\nPlease enter your player ID: "
player_id = gets.chomp.strip.to_i
print "Please enter your name or nickname: "
player_name = gets.chomp.strip

# Displays the main menu options and gets the player's input.
selected_menu = nil
until selected_menu == "3"
    puts "\n---------------"
    puts "|  Main Menu  |"
    puts "---------------"
    puts "\n1. Start game"
    puts "2. Game manual"
    puts "3. Quit game"
    print "> "
    selected_menu = gets.chomp.strip
    
    # Handles the player's main menu selection.
    #   If the input is invalid, the game starts by default.
    case selected_menu
    when "1" then enter_game(player_id, player_name); selected_menu = "3"
    when "2" then manual
    when "3" then puts "Quitting game."
    else
        puts "Invalid choice. Start game by default."
        enter_game(player_id, player_name)
        selected_menu = "3"
    end
end