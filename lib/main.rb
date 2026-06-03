=begin
Created 5/31/2026 by Kameron Johnson
Edited on 6/1/2026 by Kameron - Added loop to allow replaying the game
Edited on 6/2/2026 by Kamero Johnson - fixed mistakes from Stand Up.
  Mistakes:build a class
  added Documentation for methods using doc
  Display menu can go on one line
  single line comments in Piaza
  line 18 no parentheses
  line no parentheses 
  Rdoc
  typo in comments
  rework the loop 
=end 
require_relative 'game_environment'
class MainMenu


# Created by Kameron Johnson on 6/2/2026
# Presents the main menu and handles user game mode selection.
#
# Prompts the user to pick a game mode, validates that their input is 
# between 1 and 3, and passes the valid choice to the menu handler.
#
# @return [Boolean] true if a game was played, false if the user exited.
def run_game
  puts "Welcome to the Set Game!\nPlease select a game mode:\n1. Single Player\n2. Multiplayer(Coming soon)\n3. Exit"
  choice = gets.chomp.to_i

  #Guarantee that the user selection maps to a supported system action.
  until (1..3).include? choice
    puts "Invalid choice. Please select a valid option:"
    choice = gets.chomp.to_i
  end
  
  #Delegate the verified selection to the game system router.
  handle_menu choice
end

# Created by Kameron Johnson on 6/1/2026
# Edited by Kameron Johnson on 6/2/2026 - added documentation
# Routes the user's validated menu selection to the appropriate game action.
#
# Instantiates a new GameEnvironment, configures the selected game mode,
# and starts the game session (or handles exiting).
#
# @param [Integer] choice the validated menu option selected by the user (1, 2, or 3)
#
# @return [Boolean] true if a game session started, false if the user chose to exit.
def handle_menu choice
  #Initialize a clean session environment for the current execution.
  game = GameEnvironment.new
  #Configure the system state or terminate the session based on the routing map.
  case choice
  when 1 
    game.choose_game_mode :single_player
    game.start_game
    true
  when 2
      game.choose_game_mode :multiplayer
      game.start_game
      true
  when 3
    puts "Exiting, goodbye"
    false
  end   
     
end
end

menu = MainMenu.new


# Created 6/1/2026 by Kameron Johnson
# Edited 6/2/2026 - fixed loop control variables and routing
# 
# This script manages the core application lifecycle. It instantiates the 
# user interface and maintains the execution loop that keeps the application 
# active until the user requests a termination.
choice = true

while choice == true
  # Run the game menu and track if the user chose to play or exit
  game_was_played = menu.run_game
  
  # If run_game returned false (User selected 3. Exit), exit the loop instead of prompting to play again.
  if game_was_played == false
    choice = false
    next
  end

  # After a game session ends, prompt the user to play again. If they select 'y' or 'yes',
  # the loop will continue and present the menu again. 
  # Any other input will exit the loop and end the program.
  print "\nWould you like to play again? (y/n): "
  unless ['y', 'yes'].include? gets.chomp.downcase
    choice = false
    puts "Thanks for playing! Goodbye."
  end
end