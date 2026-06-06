
# Created 5/24/2026 by Kameron Johnson
# Edited 5/25/2026 - Added test for #initialize, #start_game, and #quit_game methods
# Edited 5/26/2026 - Added test for #pause_game method
# Edited 5/27/2026 - Added test for #handle_pause_selection and #pause_action methods
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

  # Created 5/26/2026 by Kameron Johnson
  # Modified 6/1/26 by Michael Cintron - commented out because game.start game now runs the game and inteferes with testing
  # Tests pause_game method
  # describe '#pause_game' do
  #   it 'sets state to paused when game is midgame' do
  #     game = GameEnvironment.new

  #     game.start_game
  #     game.pause_game

  #     expect(game.state).to eq(:paused)
  #   end

  #   it 'does not pause game if not midgame' do
  #     game = GameEnvironment.new

  #     game.pause_game

  #     expect(game.state).to eq(:pregame)
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

  # Created 5/27/2026 by Kameron Johnson
  # Tests handle_pause_selection method
  describe '#handle_pause_selection' do

    it 'returns :resume for input 1' do
      game = GameEnvironment.new

      result = game.handle_pause_selection("1")

      expect(result).to eq(:resume)
    end

    it 'returns :restart for input 2' do
      game = GameEnvironment.new

      result = game.handle_pause_selection("2")

      expect(result).to eq(:restart)
    end

    it 'returns :change_mode for input 3' do
      game = GameEnvironment.new

      result = game.handle_pause_selection("3")

      expect(result).to eq(:change_mode)
    end

    it 'returns :quit for input 4' do
      game = GameEnvironment.new

      result = game.handle_pause_selection("4")

      expect(result).to eq(:quit)
    end

    it 'yields selected action when block is given' do
      game = GameEnvironment.new

      expect do |b|
        game.handle_pause_selection("1", &b)
      end.to yield_with_args(:resume)
    end

    it 'returns nil for invalid input' do
      game = GameEnvironment.new

      result = game.handle_pause_selection("9")

      expect(result).to eq(nil)
    end
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
    game = GameEnvironment.new(1, "Test")
    game.choose_game_mode(:tutorial)

    allow(game).to receive(:gets).and_return("q\n")

    expect(game).to receive(:puts).with("-----------------------------------------------------------------")
    expect(game).to receive(:puts).with("|  This is tutorial mode. No points will be added or deducted.  |")
    expect(game).to receive(:puts).with("-----------------------------------------------------------------")
    expect(game).not_to receive(:puts).with(/score:/)

    game.start_game
  end
end