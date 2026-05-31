=begin
Created 5/24/2026 by Kameron Johnson
Edited 5/25/2026 - Added #initialize, #start_game, and #quit_game methods
Edited 5/26/2026 - Added #pause_game method
Edited 5/27/2026 - Added #handle_pause_selection and #pause_action methods
Edited 5/28/2026 - Fixed bug in #pause_action returning :nil symbol instead of nil
Edited 5/31/26 by Michael Cintron - Moved @deck.shuffle! call to initialize
=end
require_relative 'deck'
require_relative 'board'
require_relative 'set_validator'
class GameEnvironment

  # Created 5/25/2026 by Kameron Johnson
  # Modified 5/31/26 by Michael Cintron - moved deck shuffling here so the board gets
  #   the shuffled deck
  # Runs automatically when a new GameEnvironment object is created
  attr_reader :state, :mode
  def initialize
    @deck = Deck.new
    @deck.shuffle!
    @board = Board.new @deck
    @players = []
    @validator = SetValidator.new
    @state, @mode = :pregame, nil
  end

  # Created 5/25/2026 by Kameron Johnson
  # Modified 5/28/2026 by Michael Cintron - corrected shuffle! call
  # Modified 5/31/26 by Michael Cintron - Moved shuffle! call to initialize
  # Starts the game by shuffling the deck and setting up the board, changes state to midgame.
  def start_game
    return if @state == :midgame
    @state = :midgame
    while @state == :midgame
      @board.display_board
      puts "Drawing 3 cards..."
      cards = @deck.draw(3)
      puts cards
      setVali = SetValidator.new
      isSet = setVali.validateCards? cards[0], cards[1], cards[2]
      puts "Are they a set: #{isSet}"
      @state = :postgame
    end
  end
  
  # Created 5/26/2026 by Kameron Johnson
  # Pauses the game
  def pause_game
    return unless @state == :midgame
    @state = :paused
  end

  # Created 5/25/2026 by Kameron Johnson
  # Ends the game
  def quit_game; @state = :postgame end
  
  # Created 5/25/2026 by Kameron Johnson
  # Allows the user to select a game mode
  def choose_game_mode(mode); @mode = mode end

  # Created 5/27/2026 by Kameron Johnson
  # Handles the pause menu and returns the user's selection using a blocl
  def handle_pause_selection(choice)
    action = pause_action(choice)
    yield(action) if block_given?
    action
  end

   #Created 5/27/2026 by Kameron Johnson
   # Maps user input to corresponding actions for the pause menu
  def pause_action(choice)
    case choice
    when "1" then :resume; when "2" then :restart; when "3" then :change_mode;  when "4" then :quit; else nil end
  end

end 