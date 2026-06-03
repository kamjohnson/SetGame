=begin
Created 6/1/2026 by Kameron Johnson
Edited 6/2/2026 - Updated tests to evaluate MainMenu class instance architecture
=end
require 'main'

describe MainMenu do
  let(:mock_game) { instance_double(GameEnvironment) }
  let(:menu) { MainMenu.new } # Instantiate the class for testing

  before do
    # Stub GameEnvironment creation so we don't trigger actual game state initialization
    allow(GameEnvironment).to receive(:new).and_return(mock_game)
    allow(mock_game).to receive(:choose_game_mode)
    allow(mock_game).to receive(:start_game)
  end

  describe '#run_game' do
    it 'processes valid input for single player mode' do
      # Stub gets on the menu instance instead of self
      allow(menu).to receive(:gets).and_return("1\n")
      
      expect(mock_game).to receive(:choose_game_mode).with(:single_player)
      expect(mock_game).to receive(:start_game)
      
      menu.run_game
    end

    it 'loops and prompts again if user gives an invalid option first' do
      # Simulate user entering an invalid choice '5', then correcting to '3'
      allow(menu).to receive(:gets).and_return("5\n", "3\n")
      
      # Verify it catches the warnings outputted by the menu instance
      expect(menu).to receive(:puts).with("Welcome to the Set Game!\nPlease select a game mode:\n1. Single Player\n2. Multiplayer(Coming soon)\n3. Exit")
      expect(menu).to receive(:puts).with("Invalid choice. Please select a valid option:")
      
      menu.run_game
    end
  end

  describe '#handle_menu' do
    it 'returns true and initializes single player when 1 is selected' do
      expect(mock_game).to receive(:choose_game_mode).with(:single_player)
      expect(mock_game).to receive(:start_game)
      
      expect(menu.handle_menu(1)).to eq(true)
    end

    it 'returns false when exit option 3 is selected' do
      expect(menu.handle_menu(3)).to eq(false)
    end
  end
end