
# create 5/27 by Hongle Chen
# This file did test for checking if the deck has 81 cards and if there are no duplicate cards in the deck
require 'deck'
# Created 5/27  By Hongle Chen
describe 'deckHas81Cards' do
    it 'Return true if deck has 81 cards' do
        deck = Deck.new
        output = (deck.card_count == 81)
        expect(output).to be_truthy
    end
end
# Created 5/27  By Hongle Chen
describe 'deckHasNoDuplicateCards' do
    it 'Return true if deck has no duplicate cards' do
        deck = Deck.new

        signatures = deck.cards.map do |card|
            [card.shape, card.color, card.number, card.pattern]
        end

        output = (signatures.uniq.length == signatures.length)
        expect(output).to be_truthy
    end
end
