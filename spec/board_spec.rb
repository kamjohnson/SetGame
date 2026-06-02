=begin
File created on 6/1/26 by Michael Cintron
Edited on 6/1/26 by Kameron Johnson 
=end

require 'board'
require 'deck'
require 'card'

# Created on 6/1/26 by Michael Cintron
describe 'EmptyArrayNoCards' do
  
    it 'Return empty array if there are no cards on the board' do
		deck = Deck.new
		# deck initializes 81 cards when created - removing them all
		deck.draw 81
        board = Board.new deck
        output = board.cheat
        expect(output).to match_array([])
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'EmptyArrayOneCard' do
  
    it 'Return empty array if there is one card on the board' do
		deck = Deck.new
		deck.draw 80
        board = Board.new deck
        output = board.cheat
        expect(output).to match_array([])
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'EmptyArrayTwoCards' do
  
    it 'Return empty array if there are cards on the board' do
		deck = Deck.new
		deck.draw 79
        board = Board.new deck
        output = board.cheat
        expect(output).to match_array([])
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'ThreeArrayThreeDuplicateCards' do  
    it 'Return indexes 1, 2, 3 when the board has 3 cards that make a set' do
		deck = Deck.new
		deck.draw 81
        board = Board.new deck
		card0 = Card.new :squiggle, :red, 1, :solid
		card1 = Card.new :squiggle, :red, 1, :solid
		card2 = Card.new :squiggle, :red, 1, :solid

		board.visible_cards << card0
		board.visible_cards << card1
		board.visible_cards << card2
        expect(board.cheat).to match_array([1, 2, 3])
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'ThreeArray5Cards' do  
    it 'Return indexes 1, 3, 5 when the board has 3 cards that make a set' do
		deck = Deck.new
		deck.draw 81
        board = Board.new deck
		card0 = Card.new :squiggle, :red, 1, :solid
		card1 = Card.new :oval, :red, 1, :solid
		card2 = Card.new :squiggle, :red, 1, :solid
		card3 = Card.new :oval, :red, 1, :solid
		card4 = Card.new :squiggle, :red, 1, :solid

		board.visible_cards << card0
		board.visible_cards << card1
		board.visible_cards << card2
		board.visible_cards << card3
		board.visible_cards << card4
		output = board.cheat
        expect(output).to match_array([1, 3, 5])
    end
    
    describe '#card_count' do
    it 'retuns the correct number of visible cards' do
      deck = Deck.new
      board = Board.new(deck)
      expect(board.card_count).to eq(12)
    end
  end

end
