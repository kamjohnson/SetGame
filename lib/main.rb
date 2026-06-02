=begin
# Created 5/31/2026 by Kameron Johnson
# Edited on 6/1/2026 by Kameron - Added loop to allow replaying the game
=end 
require_relative 'game_environment'

# Created 5/31/2026 by Kameron Johnson
def display_menu
  puts "Welcome to the Set Game!\nPlease select a game mode:\n1. Single Player\n2. Multiplayer(Coming soon)\n3. Exit"
end

#Created 5/31/2026 by Kameron Johnson
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
    game.choose_game_mode(:single_player)
    game.start_game
    true
  when 2
      game.choose_game_mode(:multiplayer)
      game.start_game
      true
  when 3
    "exiting, goodbye"
    false
  end   
     
end

#Created 6/1/2026 by Kameron Johnson
#checks if the game was played, if so, prompts the user to play again, otherwise exits
loop do 
  game_was_played = run_game
  break unless game_was_played
  
  print "\nWould you like to play again? (y/n): "
  answer = gets.chomp.downcase
  unless ['y', 'yes'].include?(answer)
    puts "Thanks for playing! Goodbye."
    break
  end
  
end
