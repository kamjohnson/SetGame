require_relative 'card'
class Deck
    attr_reader :cards
    
    def initialize
        @cards = Card::SHAPE.product(Card::COLOR, Card::NUMBER,Card::PATTERN).map {|shape, color, number, pattern| Card.new(shape, color, number, pattern) }
            
        
        
    end
    
    def shuffle!
        @cards.shuffle!
    end
    
    def draw(number)
        @cards.shift(number)
    end
end


deck = Deck.new
puts "Deck has #{deck.cards.size} cards."


deck.cards.each_with_index {|cards, index| puts "#{index + 1}: #{cards}"}


count = 0
for i in 0...deck.cards.size
    if deck.cards[i] == deck.cards[i + 1]
        count += 1
    else
        count += 0
    end
end

puts "Number of duplicate cards: #{count}"

deck.shuffle!

draw_cards = deck.draw(12)


draw_cards.each_with_index {|card, index|  puts "#{index + 1}: #{card}"}
    

puts "remaining cards in deck: #{deck.cards.size}"















