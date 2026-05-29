# File created 5/28/26 by Denis Zotaj
# The Board class file is used for the playing table for the game
# This deals with the board displaying a set of 12 visible cards 
class Board
  attr_reader :visible_cards, :pending_cards

  def intialize 
    @visible_cards = []
    @pending_cards = []
  end 

  def display_board
        puts "\n - Current Board -"
        @visible_cards.each_with_index do |card, index|
            puts "#{index +1}: #{card}"
        end
    end
    
    def get_selection
        puts "\nEnter the numbers of 3 cards you want to select (e.g., 1, 2, 3):"
        input = gets.chomp

        selected_cards = input.split(',').map {|num| num.strip.to_i - 1}
        return selected_cards
    end
end
