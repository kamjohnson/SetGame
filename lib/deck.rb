# This file defines the Deck class, which represents a deck of cards for the game Set
# The Deck class initializes a standard deck of 81 unique cards , provides a method to shuffle the deck
# and allow drawing a specified number of cards from the top of the deck
# Created 5/27  By Hongle Chen
# Edited on 5/27/26 by Michael Cintron - Moved to lib folder
# Edited on 6/1/26 by Kameron Johnson - added empty? and card_count methods
# Edited on 6/2/26 by Michael Cintron - made the cards accessible so the tests can access them
require_relative 'card'
class Deck
    attr_reader :cards
    # Created 5/27  By Hongle Chen
    def initialize
        # This line by using product to create 81 unique cards, product is 3x3x3x3,which is use each elements to create cards, and none of it is duplicate
        # The terse code map put the result from product into card.new, to create 81 cards
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
    
    #Created 6/1/2026 by Kameron Johnson
    def empty?
        @cards.empty?
    end

    #Created 6/1/2026 by Kameron Johnson
    def card_count
        @cards.length
    end
end

















