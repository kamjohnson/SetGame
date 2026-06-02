=begin
File Created 6/1/2026 by Kameron Johnson: Testing card_count and remove_card methods
=end

require 'board'

describe Board do
  describe '#card_count' do
    it 'retuns the correct number of visible cards' do
      deck = Deck.new
      board = Board.new(deck)
      expect(board.card_count).to eq(12)
    end
  end
end
