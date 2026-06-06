=begin
Created 6/1/2026 by Kameron Johnson
Edited 6/2/2026 - Updated tests to evaluate MainMenu class instance architecture
Edited 6/4/2026 - Edited failing "loops and prompts again" test case to properly reflect the refactored code.ß
Edited 6/5/2026 by Joon Yoo - Updated tests for the revised MainMenu flow and player information parameters
Edited 6/5/2026 by Joon Yoo - Added tests for manual display, game mode selection, invalid input, and menu handling
=end
require 'main'

# Edited 6/5/2026 by Joon Yoo - Added player_id and player_name
describe MainMenu do
  let(:mock_game) { instance_double(GameEnvironment) }
  # Instantiate the class for testing
  let(:menu) { MainMenu.new }
  let(:player_id) { 1 }
  let(:player_name) { "Test" }

  before do
    # Stub GameEnvironment creation so we don't trigger actual game state initialization
    allow(GameEnvironment).to receive(:new).and_return(mock_game)
    allow(mock_game).to receive(:choose_game_mode)
    allow(mock_game).to receive(:start_game)
  end

  # Created 6/5/2026 by Joon Yoo
  describe '#display_manual' do
    it 'displays the game manual' do
      expect(menu).to receive(:puts).with("\n------------")
      expect(menu).to receive(:puts).with("|  Manual  |")
      expect(menu).to receive(:puts).with("------------")
      expect(menu).to receive(:puts).with("\nEach card has four attributes: shape, color, number, and pattern.")
      expect(menu).to receive(:puts).with("A set is made of three cards.")
      expect(menu).to receive(:puts).with("For each attribute, the three cards must be either all the same or all different.")
      expect(menu).to receive(:puts).with("\n- How to play -")
      expect(menu).to receive(:puts).with("Enter 3 card numbers to select a set. Example: 1 2 3")
      expect(menu).to receive(:puts).with("Enter 'd' to draw 3 more cards. Maximum of 18 cards can be on the board.")
      expect(menu).to receive(:puts).with("Enter 'q' to quit the game.")
      expect(menu).to receive(:puts).with("\n- Scoring -")
      expect(menu).to receive(:puts).with("If you choose a valid set, 3 points will be awarded.")
      expect(menu).to receive(:puts).with("If you choose an invalid set, 1 point will be deducted.")

      menu.display_manual
    end
  end

  # Created 6/5/2026 by Joon Yoo
  describe '#enter_game' do
    it 'starts tutorial mode when option 1 is selected' do
      allow(menu).to receive(:gets).and_return("1\n")

      expect(GameEnvironment).to receive(:new).with(player_id, player_name).and_return(mock_game)
      expect(mock_game).to receive(:choose_game_mode).with(:tutorial)
      expect(mock_game).to receive(:start_game)
      expect(menu.enter_game(player_id, player_name)).to eq(true)
    end

    it 'starts singleplayer mode when option 2 is selected' do
      allow(menu).to receive(:gets).and_return("2\n")

      expect(GameEnvironment).to receive(:new).with(player_id, player_name).and_return(mock_game)
      expect(mock_game).to receive(:choose_game_mode).with(:singleplayer)
      expect(mock_game).to receive(:start_game)
      expect(menu.enter_game(player_id, player_name)).to eq(true)
    end

    it 'starts multiplayer mode when option 3 is selected' do
      allow(menu).to receive(:gets).and_return("3\n")

      expect(GameEnvironment).to receive(:new).with(player_id, player_name).and_return(mock_game)
      expect(mock_game).to receive(:choose_game_mode).with(:multiplayer)
      expect(mock_game).to receive(:start_game)
      expect(menu.enter_game(player_id, player_name)).to eq(true)
    end

    it 'asks again when invalid input is entered' do
      allow(menu).to receive(:gets).and_return("4\n", "2\n")
      allow(menu).to receive(:puts)

      expect(menu).to receive(:puts).with("Invalid choice. Please select a valid option.")
      expect(GameEnvironment).to receive(:new).with(player_id, player_name).and_return(mock_game)
      expect(mock_game).to receive(:choose_game_mode).with(:singleplayer)
      expect(mock_game).to receive(:start_game)
      expect(menu.enter_game(player_id, player_name)).to eq(true)
    end
  end

  # Created 6/5/2026 by Joon Yoo
  describe '#display_main_menu' do
    it 'starts a game when option 1 is selected' do
      allow(menu).to receive(:gets).and_return("1\n")
      allow(menu).to receive(:enter_game).with(player_id, player_name).and_return(true)

      expect(menu.display_main_menu(player_id, player_name)).to eq(true)
    end

    it 'displays the manual and then quits when option 2 then option 3 are selected' do
      allow(menu).to receive(:gets).and_return("2\n", "3\n")

      expect(menu).to receive(:display_manual)
      expect(menu.display_main_menu(player_id, player_name)).to eq(false)
    end

    it 'asks again when invalid input is entered' do
      allow(menu).to receive(:gets).and_return("4\n", "3\n")
      allow(menu).to receive(:puts)

      expect(menu).to receive(:puts).with("Invalid choice. Please select a valid option.")
      expect(menu.display_main_menu(player_id, player_name)).to eq(false)
    end
  end

  # Created 6/5/2026 by Joon Yoo
  describe '#handle_menu' do
    it 'returns true when start game option is selected' do
      expect(menu).to receive(:enter_game).with(player_id, player_name).and_return(true)
      expect(menu.handle_menu("1", player_id, player_name)).to eq(true)
    end

    it 'returns false and displays manual when manual option is selected' do
      expect(menu).to receive(:display_manual)
      expect(menu.handle_menu("2", player_id, player_name)).to eq(false)
    end

    it 'returns false when quit option is selected' do
      expect(menu).to receive(:puts).with("Quitting game. Goodbye.")
      expect(menu.handle_menu("3", player_id, player_name)).to eq(false)
    end

    it 'returns false when invalid option is selected' do
      expect(menu).to receive(:puts).with("Invalid choice. Please select a valid option.")
      expect(menu.handle_menu("4", player_id, player_name)).to eq(false)
    end
  end
end
