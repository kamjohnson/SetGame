=begin
Created 5/24/2026 by Kameron Johnson
Edited 5/25/2026 - Added #initialize, #start_game, and #quit_game methods
Edited 5/26/2026 - Added #pause_game method
Edited 5/27/2026 - Added #handle_pause_selection and #pause_action methods
Edited 5/28/2026 - Fixed bug in #pause_action returning :nil symbol instead of nil
Edited 5/31/26 by Michael Cintron - Moved @deck.shuffle! call to initialize
Edited 5/31/26 - Added player input: index selection, draw option, set validation, scoring
Edited 6/1/2026 - Added player score display, handle draw requests, inputs
=end
require_relative 'deck'
require_relative 'board'
require_relative 'set_validator'
require_relative 'player'

class GameEnvironment

  # Created 5/25/2026 by Kameron Johnson
  # Modified 5/31/26 by Michael Cintron - moved deck shuffling here so the board gets
  #   the shuffled deck
  # Modified 5/31/26 by Michael Cintron - moved deck shuffling here so the board gets
  #   the shuffled deck
  # Runs automatically when a new GameEnvironment object is created
  attr_reader :state, :mode
  def initialize
    @deck = Deck.new
    @deck.shuffle!
    @board = Board.new @deck
    @players = [Player.new(1, "Player 1")]
    @validator = SetValidator.new
    @state, @mode = :pregame, nil
    @state, @mode = :pregame, nil
  end

  # Created 5/25/2026 by Kameron Johnson
  # Modified 5/28/2026 by Michael Cintron - corrected shuffle! call
  # Modified 5/31/26 by Michael Cintron - Moved shuffle! call to initialize
  # Modified 5/31/26 - Replaced test draw with interactive player input loop
  # Starts the game, then enters the main game loop where the player selects cards or draws.
  def start_game
    return if @state == :midgame
    @state = :midgame
    # get user input by hongle chen 6/1/2026
    while @state == :midgame
      @board.display_board
      puts "\nScore: #{@players[0].score}"
      puts "Enter 3 card indices (e.g. 1 2 3) to select a set,"
      puts "or enter 'd' to draw 3 more cards (max 18 on board)."
      puts "Current deck has #{@deck.cards.length} cards left."
      print "> "
      input = gets.chomp.strip

      # Handle quit
      # after I added all these updates, I found out I cant use "4" to quit, so I added "q" as a quit option 6/1/2026 by hongle chen
      if input.downcase == 'q'
        puts "Quitting game. Final score: #{@players[0].score}"
        quit_game
        next
      end

      # Handle draw request 6/1/2026 by hongle chen
      if input.downcase == 'd'
        if @board.visible_cards.length >= 18
          puts "Board already has #{@board.visible_cards.length} cards (max 18). Cannot draw more."
        elsif @deck.cards.empty?
          puts "No cards left in the deck to draw."
        else
          new_cards = @deck.draw(3)
          @board.visible_cards.concat(new_cards) # add new cards to the board's visible cards
          puts "Drew #{new_cards.length} card(s):"
          new_cards.each { |c| puts "  #{c}" }  # for each new card, print it out tell the user what they drew
          # line 58 59 not necessary but it is nice to give the user feedback on what they drew and how many cards are now on the board
        end
        next # in invalid input case, skip the rest of the loop and prompt again, same for all nexts below 6/1/2026 by hongle chen
      end

      # Parse three indices 6/1/2026 by hongle chen
      indices = input.split.map{|s| s.to_i} # convert input to array of integers
      # split is used to separate the input string into parts based on spaces, and map(&:to_i) converts each part to an integer.
      # So if the user enters "1 2 3", indices will be [1, 2, 3].
      unless indices.length == 3
        puts "Please enter exactly 3 indices."
        next
      end

      # Validate index range 6/1/2026 by hongle chen
      max_index = @board.visible_cards.length
      unless indices.all? { |i| i >= 1 && i <= max_index }
        puts "Indices must be between 1 and #{max_index}."
        next
      end

      # Ensure no duplicate indices 6/1/2026 by hongle chen
      if indices.uniq.length != 3
        puts "Please enter 3 different indices."
        next
      end

      # out put the selection to player what they selected last round 6/1/2026 by hongle chen
      selected = indices.map { |i| @board.visible_cards[i - 1] } # i-1 because display are 1-12, but index is 0-11
      puts "\nYou selected:"
      selected.each_with_index { |c, i| puts "  #{indices[i]}: #{c}" } # for each selected card, print out the index and the card itself 6/1/2026 by hongle chen

      # Validate set 6/1/2026 by hongle chen
      if @validator.validateCards?(selected[0], selected[1], selected[2])
        puts "Valid set! +1 point."
        @players[0].addPoint(1)
        @board.visible_cards.reject! { |c| selected.include?(c) } # remove the selected cards from the board's visible cards if they are valid set 6/1/2026 by hongle chen
        # Refill to 12 if deck has cards and board fell below 12 6/1/2026 by hongle chen
        while @board.visible_cards.length < 12 && !@deck.cards.empty?
          @board.visible_cards.concat(@deck.draw(3))
        end
        puts "Score: #{@players[0].score}"
        if @board.visible_cards.empty? && @deck.cards.empty?
          puts "\nNo more cards! Game over. Final score: #{@players[0].score}"
          @state = :postgame
        end
      else
        puts "Not a valid set. Try again."
      end
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
  # Handles the pause menu and returns the user's selection using a block
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