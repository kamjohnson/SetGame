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
    @visible_cards.each do |card|
      puts card.to_s
    end
    
    # have more def to add regarding actually replacing cards
    # and locking the cards so other player can't select
end
