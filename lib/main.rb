=begin
# Created 5/31/2026 by Kameron Johnson
=end 
require_relative 'game_environment'

def display_menu
  puts "Welcome to the Set Game!\nPlease select a game mode:\n1. Single Player\n2. Multiplayer(Coming soon)\n3. Exit"
end

def run_game
  display_menu
  choice = gets.chomp.to_i

  # check to see if input is valid
  until (1..3).include?(choice)
    puts "Invalid choice. Please select a valid option:"
    choice = gets.chomp.to_i
  end
   
  handle_menu(choice)
end

#pass valid input into method strating the game
def handle_menu choice
  game = GameEnvironment.new
  case choice
  when 1 
    game.mode = :single_player
    game.single_player_gameplay 
    
  when 2
      game.choose_game_mode(:multiplayer)
      game.start_game
      "Multiplayer mode"
  when 3
    "exiting, goodbye"
  end   
     
end

run_game