=begin
File created 5/28/26 by Denis Zotaj
File modified 6/1/26 by Michael Cintron - added a cheat method
Edited 6/1/2026 by Kameron Johnson - added card_count method and replaced direct calls to visible_cards.length with card_count for better encapsulation
Edited 6/2/26 by Michael Cintron - Made tabbing consistent, added comments for cheat
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

	# Created 5/28/26 by Denis Zotaj
	# Edited 6/2/26 by Michael Cintron - Standardizing documentation
	# Draw 12 cards for the start of the game
	def initialize(deck) 
		@visible_cards = deck.draw(12)
	end 

	# Created 5/28/26 by Denis Zotaj
  # Edited 6/2/26 by Michael Cintron - Standardizing documentation
	# Display all the cards on the board, denote with a user friendly index value.
	def display_board
		puts "\n - Current Board -"
		@visible_cards.each_with_index do |card, index| 
			puts "#{index + 1}: #{card}"
		end
	end
    
	# Created 5/28/26 by Denis Zotaj
	# Edited 6/2/26 by Michael Cintron - Standardizing documentation
	# Remove the cards given in set_cards from the board and draw 3 new cards
	# to replace them, if there are still cards in the deck.
	# 
	# @param [Array] set_cards - array of cards to be removed from the board.
	# @param [Deck] deck - The game's deck object.
	# 
	# @return [Array] - The cards on the board with the 3 replacement cards
	def replace_cards(set_cards, deck)
			@visible_cards.reject! {|card| set_cards.include?(card)}
			new_cards = deck.draw(3)
			@visible_cards.concat(new_cards) unless new_cards.empty?
	end
	
	# Created 6/1/2026 by Kameron Johnson
	# Edited 6/2/26 by Michael Cintron - Standardizing documentation & terse-ifying
	# Get the number of cards currently on the board
	# 
	# @return [Integer] - the number of cards on the board
	def card_count () @visible_cards.length end
			
	# Created 6/1/2026 by Kameron Johnson
	# Edited 6/2/26 by Michael Cintron - Standardizing documentation & terse-ifying
	# Remove a specific card from the board.
	# 
	# @param [Card] card - a card to be removed from the board.
	# 
	# @return [Card] - the removed card
	def remove_card(card) @visible_cards.delete(card) end 
  
	# Created on 6/1/26 by Michael Cintron
	# Edited on 6/2/26 by Michael Cintron - added comments
	# Check the visible cards and returns the indexes of three cards that make a set, if there is a set
	# 
	# @return [array] of 3 numbers of the indexes of three cards that make a set, otherwise return an empty array
	def cheat
		boardDeckLength = @visible_cards.length
		# if there are less than 3 cards on the board, early return as no sets can be made
		return [] if boardDeckLength < 3
		setVali = SetValidator.new
		
		# go through all cards, but excluding the last two
		for index0 in 0..boardDeckLength - 3 do
			# go through all cards from the card after index0, but excluding the last one
			for index1 in index0 + 1..boardDeckLength - 2 do
				# go through all cards from the card after index1
				for index2 in index1 + 1..boardDeckLength - 1 do
					# if the current 3 indexed cards make a set, return their game indices
					return [index0 + 1, index1 + 1, index2 + 1] if 
						setVali.validateCards? @visible_cards[index0], @visible_cards[index1], @visible_cards[index2]
				end
			end
		end
		
		# return an empty array if no set is found
		[]
	end
end