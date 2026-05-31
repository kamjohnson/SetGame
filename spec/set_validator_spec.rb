require 'set_validator'
require 'card'

# File created on 5/27/26 by Michael Cintron

# Created on 5/27/26 by Michael Cintron
describe 'validShapesAllSame' do
    it 'Return true if all shapes are the same' do
        setVali = SetValidator.new
        output = setVali.validateProperty?(:squiggle, :squiggle, :squiggle)
        expect(output).to be_truthy
    end
end

# Created on 5/27/26 by Michael Cintron
describe 'invalidShapesOneDifferent' do
    it 'Return false if one shape is different' do
        setVali = SetValidator.new
        output = setVali.validateProperty?(:squiggle, :squiggle, :oval)
        expect(output).to be_falsey
    end
end

# Created on 5/27/26 by Michael Cintron
describe 'validShapesAllDifferent' do
    it 'Return true if all shape are different' do
        setVali = SetValidator.new
        output = setVali.validateProperty?(:squiggle, :oval, :diamond)
        expect(output).to be_truthy
    end
end

# Created on 5/28/26 by Michael Cintron
describe 'validSetAllSame' do
    it 'Return true if all the cards are the same' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :red, 1, :solid
        card1 = Card.new :squiggle, :red, 1, :solid
        card2 = Card.new :squiggle, :red, 1, :solid
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_truthy
    end
end

# Created on 5/28/26 by Michael Cintron
describe 'invalidSetOneDifferenceShape' do
    it 'Return false if only one property is different' do
        setVali = SetValidator.new
        card0 = Card.new :oval, :red, 1, :solid
        card1 = Card.new :squiggle, :red, 1, :solid
        card2 = Card.new :squiggle, :red, 1, :solid
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_falsey
    end
end

# Created on 5/28/26 by Michael Cintron
describe 'invalidSetOneDifferenceColor' do
    it 'Return false if only one property is different' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :green, 1, :solid
        card1 = Card.new :squiggle, :red, 1, :solid
        card2 = Card.new :squiggle, :red, 1, :solid
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_falsey
    end
end

# Created on 5/28/26 by Michael Cintron
describe 'invalidSetOneDifferenceCount' do
    it 'Return false if only one property is different' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :red, 2, :solid
        card1 = Card.new :squiggle, :red, 1, :solid
        card2 = Card.new :squiggle, :red, 1, :solid
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_falsey
    end
end

# Created on 5/28/26 by Michael Cintron
describe 'invalidSetOneDifferenceCount' do
    it 'Return false if only one property is different' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :red, 1, :striped
        card1 = Card.new :squiggle, :red, 1, :solid
        card2 = Card.new :squiggle, :red, 1, :solid
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_falsey
    end
end

# Created on 5/28/26 by Michael Cintron
describe 'validSetAllDifferent' do
    it 'Return true if all the cards are completely different' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :red, 1, :solid
        card1 = Card.new :oval, :green, 2, :striped
        card2 = Card.new :diamond, :purple, 3, :open
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_truthy
    end
end

# Created on 5/31/26 by Michael Cintron
describe 'invalidSetTwoShapesShared' do
    it 'Return false if all the cards are completely different EXCEPT two cards have the same shape' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :red, 1, :solid
        card1 = Card.new :squiggle, :green, 2, :striped
        card2 = Card.new :diamond, :purple, 3, :open
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_falsey
    end
end

# Created on 5/31/26 by Michael Cintron
describe 'validSetTwoPropertiesShared' do
    it 'Return true if all the cards share shape and color, but all different counts and shading' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :red, 1, :solid
        card1 = Card.new :squiggle, :red, 2, :striped
        card2 = Card.new :squiggle, :red, 3, :open
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_truthy
    end
end

# Created on 5/31/26 by Michael Cintron
describe 'validSetThreePropertiesShared' do
    it 'Return true if all the cards share shape, color, and count, but all different shading' do
        setVali = SetValidator.new
        card0 = Card.new :squiggle, :red, 1, :solid
        card1 = Card.new :squiggle, :red, 1, :striped
        card2 = Card.new :squiggle, :red, 1, :open
        
        output = setVali.validateCards?(card0, card1, card2)
        expect(output).to be_truthy
    end
end