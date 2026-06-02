=begin
File created 5/28/26 by Denis Zotaj
File modified 6/1/26 by Michael Cintron - added a cheat method
The Board class file is used for the playing table for the game
This deals with the board displaying a set of 12 visible cards 
=end
require_relative 'card'
require_relative 'deck'
require_relative 'set_validator'

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

	# Created on 6/1/26 by Michael Cintron
	# Check the visible cards and returns the indexes of three cards that make a set, if there is a set
	# 
	# return [array] of 3 numbers of the indexes of three cards that make a set, otherwise return an empty array
	def cheat
		boardDeckLength = @visible_cards.length
		return [] if boardDeckLength < 3
		setVali = SetValidator.new
		
		for index0 in 0..boardDeckLength - 3 do
			for index1 in index0 + 1..boardDeckLength - 2 do
				for index2 in index1 + 1..boardDeckLength - 1 do
					return [index0 + 1, index1 + 1, index2 + 1] if setVali.validateCards?(@visible_cards[index0], @visible_cards[index1], @visible_cards[index2])
				end
			end
		end

		# return [1, 2, 3] if setVali.validateCards? @visible_cards[0], @visible_cards[1], @visible_cards[2]		
		[]
	end


    #Created 6/1/2026 by Kameron Johnson
    def card_count
        @visible_cards.length
    end
        
    #Created 6/1/2026 by Kameron Johnson
     def remove_card(card)
        @visible_cards.delete(card)
     end 
  
end

