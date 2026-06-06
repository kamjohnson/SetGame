=begin
Created 5/31/2026 by Kameron Johnson
Edited on 6/1/2026 by Kameron Johnson - Added loop to allow replaying the game
Edited on 6/2/2026 by Kameron Johnson - Fixed mistakes from Stand Up.
  Mistakes:
  build a class
  added Documentation for methods using doc
  Display menu can go on one line
  single line comments in Piazza
  line 18 no parentheses
  line no parentheses 
  Rdoc
  typo in comments
  rework the loop
Edited on 6/4/2026 by Joon Yoo - Added manual and player information input
Edited on 6/4/2026 by Joon Yoo - Reworked menu flow into main menu and game mode selection
Edited on 6/5/2026 by Joon Yoo - Updated replay flow and input handling
Edited on 6/5/2026 by Joon Yoo - Updated method documentation, single line comments, and file formatting
=end 
require_relative 'game_environment'

class MainMenu
  # Created 6/4/2026 by Joon Yoo
  # Displays the game manual, including card attributes, set rules, controls, and scoring.
  #
  # @return [nil] after displaying the manual to the terminal
  def display_manual
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

  # Created 6/4/2026 by Joon Yoo
  # Handles game mode selection, creates a GameEnvironment object, and starts the game.
  #
  # Prompts the player to choose game mode.
  # If the player enters invalid input, keeps asking until a valid mode is selected.
  #
  # @param [Integer] player_id - The player's ID number
  # @param [String] player_name - The player's name or nickname
  #
  # @return [Boolean] true after a game session
  def enter_game player_id, player_name
    choice = nil

    # Displays the game mode options and keeps asking until the player enters valid input.
    until ["1", "2", "3"].include? choice
      puts "\nPlease select a game mode"
      puts "1. Tutorial mode"
      puts "2. Singleplayer mode"
      print "3. Multiplayer mode\n> "
      choice = gets.chomp.strip
      unless ["1", "2", "3"].include? choice
        puts "Invalid choice. Please select a valid option."
      end
    end

    # Sets the game mode symbol based on the player's input.
    mode = case choice
    when "1" then :tutorial
    when "2" then :singleplayer
    when "3" then :multiplayer end

    # Creates a game session using the player's information.
    game = GameEnvironment.new(player_id, player_name)

    # Applies the selected game mode and starts the game.
    game.choose_game_mode mode
    game.start_game
    true
  end

  # Created by Kameron Johnson on 6/2/2026
  # Edited 6/4/2026 by Joon Yoo - Moved game mode selection to enter_game method
  # Edited 6/4/2026 by Joon Yoo - Renamed the method
  # Edited 6/4/2026 by Joon Yoo - Added game manual option and player information parameters
  # Edited 6/5/2026 by Joon Yoo - Updated the method to leave the main menu
  # Presents the main menu and handles the user's main menu selection.
  #
  # Displays the main menu until the player starts a game or chooses to quit.
  # If the player starts a game, the method exits the main menu so the replay prompt can run.
  #
  # @param [Integer] player_id - The player's ID number
  # @param [String] player_name - The player's name or nickname
  #
  # @return [Boolean] true if a game was played, false if no game session started.
  def display_main_menu player_id, player_name
    choice = nil
    game_was_played = false

    # Displays the main menu options until the player starts or quits the game.
    until choice == "3"
      puts "\n---------------"
      puts "|  Main Menu  |"
      puts "---------------"
      puts "\n1. Start game"
      puts "2. Game manual"
      print "3. Quit game\n> "
      choice = gets.chomp.strip
    
      # Delegates the player's selection to the menu handler.
      game_was_played = handle_menu choice, player_id, player_name

      # Leaves the main menu after a game session so the replay prompt can run.
      choice = "3" if game_was_played == true
    end
    game_was_played
  end

  # Created by Kameron Johnson on 6/1/2026
  # Edited by Kameron Johnson on 6/2/2026 - added documentation
  # Edited 6/4/2026 by Joon Yoo - Added player information parameters
  # Edited 6/4/2026 by Joon Yoo - Changed menu input handling from Integer to String
  # Edited 6/4/2026 by Joon Yoo - Moved GameEnvironment creation and game mode selection to enter_game method
  # Edited 6/4/2026 by Joon Yoo - Updated routing to support start game, manual, quit, and invalid input
  # Routes the user's menu selection to the appropriate game action.
  #
  # @param [String] choice - the validated menu option selected by the user
  # @param [Integer] player_id - The player's ID number
  # @param [String] player_name - The player's name or nickname
  #
  # @return [Boolean] true if a game session started, false if no game session started.
  def handle_menu choice, player_id, player_name
    game_was_played = false

    # Routes each main menu option to the correct action.
    case choice
    when "1" then game_was_played = enter_game player_id, player_name
    when "2" then display_manual
    when "3" then puts "Quitting game. Goodbye."
    else puts "Invalid choice. Please select a valid option." end
    game_was_played
  end
end

# Created 6/1/2026 by Kameron Johnson
# Edited 6/2/2026 - fixed loop control variables and routing
# Edited 6/4/2026 - added __FILE__ guard to prevent auto-launch during testing
# Edited 6/4/2026 by Joon Yoo - Added welcome message and player information input
# Edited 6/4/2026 by Joon Yoo - Moved MainMenu object creation inside the __FILE__ guard
# Edited 6/4/2026 by Joon Yoo - Updated the game session to call display_main_menu with player information
# Edited 6/5/2026 by Joon Yoo - Removed the loop control using choice variable
# Edited 6/5/2026 by Joon Yoo - Updated the replay loop to use game_was_played as the loop condition
# Edited 6/5/2026 by Joon Yoo - Fixed loop flow to go directly to game mode selection after the game
#
# This script manages the core application lifecycle. It instantiates the 
# user interface and maintains the execution loop that keeps the application 
# active until the user requests a termination.
if __FILE__ == $0
  # Displays the welcome message.
  puts "---------------------------------"
  puts "|  Welcome to the Game of Set!  |"
  puts "---------------------------------"

  # Gets the player's ID and name before starting the game.
  print "\nPlease enter your player ID\n> "
  player_id = gets.chomp.strip.to_i
  print "\nPlease enter your name or nickname\n> "
  player_name = gets.chomp.strip

  # Creates the menu object only when this file is run directly.
  menu = MainMenu.new

  # Displays the main menu for the game session.
  game_was_played = menu.display_main_menu player_id, player_name

  # Replays the game directly from game mode selection after the game.
  while game_was_played
    print "\nWould you like to play again? (y/n)\n> "
    answer = gets.chomp.strip.downcase

    # Starts another game if the player chooses "y" or "yes", otherwise exits the program.
    if ["y", "yes"].include? answer then game_was_played = menu.enter_game player_id, player_name
    else game_was_played = false; puts "Thanks for playing! Goodbye." end
  end
end