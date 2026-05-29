# This file defines the Deck class, which represents a deck of cards for the game Set
# The Deck class initializes a standard deck of 81 unique cards , provides a method to shuffle the deck
# and allow drawing a specified number of cards from the top of the deck
# Created 5/27  By Hongle Chen
# Edited on 5/27/27 by Michael Cintron - Moved to lib folder
require_relative 'card'
class Deck
    attr_reader :cards
    # Created 5/27  By Hongle Chen
    def initialize
        @cards = Card::SHAPE.product(Card::COLOR, Card::NUMBER,Card::PATTERN).map {|shape, color, number, pattern| Card.new(shape, color, number, pattern) }
            
        
        
    end
    # Created 5/27  By Hongle Chen
    def shuffle!
        @cards.shuffle!
    end
    # Created 5/27  By Hongle Chen
    def draw(number)
        @cards.shift(number)
    end
end

















