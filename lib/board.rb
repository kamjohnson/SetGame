# File created 5/28/26 by Denis Zotaj
# The Board class file is used for the playing table for the game
# This deals with the board displaying a set of 12 visible cards 
require_relative 'card'
require_relative 'deck'

# File created 5/28/26 by Denis Zotaj
# File modified 6/1/2026 by hongle chen - changed :visible_cards to attr_accessor
# The Board class file is used for the playing table for the game
# This deals with the board displaying a set of 12 visible cards 
require_relative 'card'
require_relative 'deck'

class Board
  # moved to attr_accessor so GameEnvironment can modify the visible cards when sets are found or new cards are drawn
  attr_accessor :visible_cards 
  attr_reader :pending_cards

  def initialize(deck) 
    @visible_cards = deck.draw(12)
    @pending_cards = []
  end 

  def display_board
        puts "\n - Current Board -"
        @visible_cards.each_with_index do |card, index|
            puts "#{index +1}: #{card}"
        end
    end
    
    def replace_cards(set_cards, deck)
        @visible_cards.reject! {|card| set_cards.include?(card)}
        new_cards = deck.draw(3)
        @visible_cards.concat(new_cards) unless new_cards.empty?
    end
end
