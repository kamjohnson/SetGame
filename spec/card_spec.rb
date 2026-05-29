require 'card'
# check if a valid card can be created
# check if wrong element will raise error
# check if the string representation of a card is correct   
# create 5/27 by Hongle Chen
describe 'validCardInitialization' do
    it 'Return true if a valid card can be created' do
        card = Card.new(:squiggle, :red, 1, :solid)
        output = (card.shape == :squiggle &&
                  card.color == :red &&
                  card.number == 1 &&
                  card.pattern == :solid)
        expect(output).to be_truthy
    end
end
# create 5/27 by Hongle Chen
describe 'invalidShape' do
    it 'Raise error if shape is invalid' do
        expect { Card.new(:circle, :red, 1, :solid) }.to raise_error(ArgumentError)
    end
end
# create 5/27 by Hongle Chen
describe 'invalidColor' do
    it 'Raise error if color is invalid' do
        expect { Card.new(:squiggle, :blue, 1, :solid) }.to raise_error(ArgumentError)
    end
end
# create 5/27 by Hongle Chen
describe 'invalidNumber' do
    it 'Raise error if number is invalid' do
        expect { Card.new(:squiggle, :red, 4, :solid) }.to raise_error(ArgumentError)
    end
end
# create 5/27 by Hongle Chen
describe 'invalidPattern' do
    it 'Raise error if pattern is invalid' do
        expect { Card.new(:squiggle, :red, 1, :filled) }.to raise_error(ArgumentError)
    end
end
# create 5/27 by Hongle Chen
describe 'cardToString' do
    it 'Return correct string representation of a card' do
        card = Card.new(:diamond, :green, 3, :striped)
        output = card.to_s
        expect(output).to eq('3 green striped diamond')
    end
end
