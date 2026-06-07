
# Created 5/24/2026 by Kameron Johnson
# Edited 5/25/2026 - Added test for #initialize, #start_game, and #quit_game methods
# Edited 5/26/2026 - Added test for #pause_game method
# Edited 5/27/2026 - Added test for #handle_pause_selection and #pause_action methods
# Edited 6/6/2026 by Joon Yoo - Removed all tests related to pause feature
# RSpec tests for GameEnvironment class
require 'game_environment'
describe GameEnvironment do

  # Created 5/25/2026 by Kameron Johnson
  # Tests initialize method
  describe '#initialize' do

    it 'starts in pregame state' do
      game = GameEnvironment.new
      expect(game.state).to eq(:pregame)
    end

    it 'initializes with nil mode' do
      game = GameEnvironment.new
      expect(game.mode).to eq(nil)
    end

    it 'initializes with an array of players' do
      players = [Player.new(1, "Test 1"), Player.new(2, "Test 2")]
      game = GameEnvironment.new(players)

      expect(game.state).to eq(:pregame)
      expect(game.mode).to eq(nil)
    end
  end

  # 
  # Created 5/25/2026 by Kameron Johnson
  # Modified 6/1/26 by Michael Cintron - commented out because game.start game now runs the game and inteferes with testing
  # Tests start_game method
  # describe '#start_game' do

  #   it 'changes state from pregame to midgame' do
  #     game = GameEnvironment.new

  #     game.start_game

  #     expect(game.state).to eq(:midgame)
  #   end

  #   it 'does not restart game if already midgame' do
  #     game = GameEnvironment.new

  #     game.start_game
  #     game.start_game

  #     expect(game.state).to eq(:midgame)
  #   end
  # end
  
  # Created 5/25/2026 by Kameron Johnson
  # Modified 6/1/26 by Michael Cintron - commented out because game.start game now runs the game and inteferes with testing
  # Tests quit_game method
  # describe '#quit_game' do

  #   it 'sets state to postgame' do
  #     game = GameEnvironment.new

  #     game.quit_game

  #     expect(game.state).to eq(:postgame)
  #   end

  #   it 'can quit from any state' do
  #     game = GameEnvironment.new

  #     game.start_game
  #     game.pause_game
  #     game.quit_game

  #     expect(game.state).to eq(:postgame)
  #   end
  # end

  # Created 5/25/2026 by Kameron Johnson
  # Tests choose_game_mode method
  describe '#choose_game_mode' do

    it 'sets game mode during pregame' do
      game = GameEnvironment.new

      game.choose_game_mode(:timed)

      expect(game.mode).to eq(:timed)
    end
  end

# Created on 6/1/26 by Michael Cintron
describe 'invalidInputEmpty' do
    it 'Return false if the given string is empty' do
        game = GameEnvironment.new
        output = game.valid_card_selection? ""
        expect(output).to be_falsey
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'invalidInputOneNumber' do
    it 'Return false if the given string is one number' do
        game = GameEnvironment.new
        output = game.valid_card_selection? "1"
        expect(output).to be_falsey
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'invalidInputTwoNumbers' do
    it 'Return false if the given string is two space seperated numbers' do
        game = GameEnvironment.new
        output = game.valid_card_selection? "1 2"
        expect(output).to be_falsey
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'validInputThreeNumbers' do
    it 'Return true if the given string is three space seperated numbers' do
        game = GameEnvironment.new
        output = game.valid_card_selection? "1 2 3"
        expect(output).to be_truthy
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'invalidInputFourCharacters' do
    it 'Return false if the given string is four space seperated characters' do
        game = GameEnvironment.new
        output = game.valid_card_selection? "1 2 3 4"
        expect(output).to be_falsey
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'invalidInputThreeLetters' do
    it 'Return false if the given string is three space seperated characters' do
        game = GameEnvironment.new
        output = game.valid_card_selection? "a b c"
        expect(output).to be_falsey
    end
end

# Created on 6/1/26 by Michael Cintron
describe 'invalidInputThreeDuplicateNumbers' do
    it 'Return false if the given string is three space seperated numbers that are the same number' do
        game = GameEnvironment.new
        output = game.valid_card_selection? "1 1 1"
        expect(output).to be_falsey
    end
end

describe 'invalidInputOverIndex' do
    it 'Return false if any of the given numbers are not between 1 and 12' do
        game = GameEnvironment.new
        output = game.valid_card_selection? "1 2 13"
        expect(output).to be_falsey
    end
end

# Created 6/6/2026 by Joon Yoo
describe 'tutorial_mode' do
  it 'displays tutorial message and hides score output' do
    game = GameEnvironment.new([Player.new(1, "Test")])
    game.choose_game_mode(:tutorial)

    allow(game).to receive(:gets).and_return("q\n")

    expect(game).to receive(:puts).with("-----------------------------------------------------------------")
    expect(game).to receive(:puts).with("|  This is tutorial mode. No points will be added or deducted.  |")
    expect(game).to receive(:puts).with("-----------------------------------------------------------------")
    expect(game).not_to receive(:puts).with(/score:/)

    game.start_game
  end
end

# Created 6/6/2026 by Joon Yoo
  describe '#select_current_player' do
    it 'returns the selected multiplayer player' do
      players = [Player.new(1, "Test 1"), Player.new(2, "Test 2")]
      game = GameEnvironment.new(players)

      allow(game).to receive(:gets).and_return("2\n")
      allow(game).to receive(:puts)
      allow(game).to receive(:print)
      
      selected_player = game.select_current_player
      expect(selected_player.playerName).to eq("Test 2")
      expect(selected_player.playerID).to eq(2)
    end

    it 'asks again when the player number is invalid' do
      players = [Player.new(1, "Test 1"), Player.new(2, "Test 2")]
      game = GameEnvironment.new(players)

      allow(game).to receive(:gets).and_return("3\n", "1\n")
      allow(game).to receive(:puts)
      allow(game).to receive(:print)

      expect(game).to receive(:puts).with("Invalid player number.")
      selected_player = game.select_current_player
      expect(selected_player.playerName).to eq("Test 1")
    end
  end

  # Created 6/6/2026 by Joon Yoo
  describe '#display_multiplayer_score' do
    it 'displays all multiplayer scores' do
      players = [Player.new(1, "Test 1"), Player.new(2, "Test 2")]
      game = GameEnvironment.new(players)

      expect(game).to receive(:puts).with("1. Test 1 | ID: 1 | Score: 0")
      expect(game).to receive(:puts).with("2. Test 2 | ID: 2 | Score: 0")
      game.display_multiplayer_score
    end
  end
end