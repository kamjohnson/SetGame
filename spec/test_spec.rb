require 'tester'

describe 'Tester0' do
    it 'accepts goods inputs' do
        test = Tester.new
        tested = test.testing("good")
        expect(tested).to be_truthy
    end
end

describe 'Tester1' do
    it 'rejects bad inputs' do
        test = Tester.new
        tested = test.testing("not good")
        expect(tested).to be_falsey
    end
end