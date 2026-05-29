require 'set_validator'

# File created on 5/27/26 by Michael Cintron

# Created on 5/27/26 by Michael Cintron
describe 'validShapesAllSame' do
    it 'Return true if all shapes are the same' do
        setVali = SetValidator.new
        output = setVali.validateShape(:squiggle, :squiggle, :squiggle)
        expect(output).to be_truthy
    end
end

# Created on 5/27/26 by Michael Cintron
describe 'invalidShapesOneDifferent' do
    it 'Return false if one shape is different' do
        setVali = SetValidator.new
        output = setVali.validateShape(:squiggle, :squiggle, :oval)
        expect(output).to be_falsey
    end
end

# Created on 5/27/26 by Michael Cintron
describe 'validShapesAllDifferent' do
    it 'Return true if all shape are different' do
        setVali = SetValidator.new
        output = setVali.validateShape(:squiggle, :oval, :diamond)
        expect(output).to be_truthy
    end
end
