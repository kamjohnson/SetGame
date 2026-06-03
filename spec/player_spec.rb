# File created 5/28/2026 by Joon Yoo

require 'player'

# Created 5/28/2026 by Joon Yoo
describe 'playerDefault' do
    it 'Return true if player has default arguments' do
        player = Player.new
        expect(player.playerID == 0).to be_truthy
        expect(player.playerName == "Anonymous").to be_truthy
        expect(player.score == 0).to be_truthy
    end
end

# Created 5/28/2026 by Joon Yoo
describe 'invalidPlayerDefault' do
    it 'Return false if player does not have default arguments' do
        player = Player.new
        expect(player.playerID == 1).to be_falsey
        expect(player.playerName == "Joon").to be_falsey
        expect(player.score == 1).to be_falsey
    end
end

# Created 5/28/2026 by Joon Yoo
describe 'playerWithInput' do
    it 'Return true if player has user given arguments' do
        player = Player.new 1, "Joon", 1
        expect(player.playerID == 1).to be_truthy
        expect(player.playerName == "Joon").to be_truthy
        expect(player.score == 1).to be_truthy
    end
end

# Created 5/28/2026 by Joon Yoo
describe 'invalidPlayerWithInput' do
    it 'Return false if player does not have user given arguments' do
        player = Player.new 1, "Joon", 1
        expect(player.playerID == 0).to be_falsey
        expect(player.playerName == "Anonymous").to be_falsey
        expect(player.score == 0).to be_falsey
    end
end

# Created 5/28/2026 by Joon Yoo
describe 'addPoint' do
    it 'Return true if points are added to the player score by the given amount' do
        player = Player.new
        player.addPoint 1
        expect(player.score == 1).to be_truthy
        player.addPoint 2
        expect(player.score == 3).to be_truthy
        player.addPoint 3
        expect(player.score == 6).to be_truthy
    end
end

# Created 5/28/2026 by Joon Yoo
describe 'invalidAddPoint' do
    it 'Return false if points are added incorrectly to the player score by the given amount' do
        player = Player.new
        player.addPoint 1
        expect(player.score == 2).to be_falsey
        player.addPoint 2
        expect(player.score == 4).to be_falsey
        player.addPoint 3
        expect(player.score == 7).to be_falsey
    end
end

# Created 5/28/2026 by Joon Yoo
# Edited on 6/2/26 by Michael Cintron - updated deduct point to never go below 0
describe 'deductPoint' do
    it 'Return true if points are deducted from the player score by the given amount' do
        player = Player.new 1, "Joon", 5
        player.deductPoint 3
        expect(player.score == 2).to be_truthy
        player.deductPoint 2
        expect(player.score == 0).to be_truthy
        player.deductPoint 1
        expect(player.score == 0).to be_truthy
    end
end

# Created 5/28/2026 by Joon Yoo
describe 'invalidDeductPoint' do
    it 'Return false if points are deducted incorrectly from the player score by the given amount' do
        player = Player.new 1, "Joon", 5
        player.deductPoint 3
        expect(player.score == 1).to be_falsey
        player.deductPoint 2
        expect(player.score == 3).to be_falsey
        player.deductPoint 1
        expect(player.score == -2).to be_falsey
    end
end


