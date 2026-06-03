=begin
Created 5/24/2026 by Kameron Johnson
Edited 5/25/2026 - Added #initialize, #start_game, and #quit_game methods
Edited 5/26/2026 - Added #pause_game method
Edited 5/27/2026 - Added #handle_pause_selection and #pause_action methods
Edited 5/28/2026 - Fixed bug in #pause_action returning :nil symbol instead of nil
Edited 5/31/26 by Michael Cintron - Moved @deck.shuffle! call to initialize
Edited 5/31/26 - Added player input: index selection, draw option, set validation, scoring
Edited 6/1/2026 - Added player score display, handle draw requests, inputs
Edited 6/1/2026 by Joon Yoo - Modified initialize method to accept player information as parameters
    when creating a player object
Edited 6/1/2026 by Joon Yoo - Updated score display to show the player’s name along with the score.
Edited 6/1/2026 by Joon Yoo - Added point deduction when the player selects an invalid set.
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
  # Modified 6/1/2026 by Joon Yoo - Added player ID and name parameters
  #   so GameEnvironment can create a player using user input from main.
  #   Also removed the duplicated statement: @state, @mode = :pregame, nil
  attr_reader :state, :mode
  def initialize player_id = 1, player_name = "Player 1"
    @deck = Deck.new
    @deck.shuffle!
    @board = Board.new @deck
    @players = [Player.new(player_id, player_name)]
    @validator = SetValidator.new
    @state, @mode = :pregame, nil
  end

  # Created 5/25/2026 by Kameron Johnson
  # Modified 5/28/2026 by Michael Cintron - corrected shuffle! call
  # Modified 5/31/26 by Michael Cintron - Moved shuffle! call to initialize
  # Modified 5/31/26 - Replaced test draw with interactive player input loop
  # Modified 6/1/26 by Hongle Chen - Implemented game loop.
  # Modified 6/1/26 by Michael Cintron - clean up comments and moved card validation into its own function
  # Starts the game, then enters the main game loop where the player selects cards or draws.
  # Modified 6/1/2026 by Joon Yoo - Added the player’s name to the score output statement.
  # Modified 6/1/2026 by Joon Yoo - Adjusted the points awarded for finding a valid set to 3 points.
  # Modified 6/1/2026 by Joon Yoo - Added a feature that deducts 1 point when an invalid set is found.
  def start_game
    # return if @state == :midgame
    @state = :midgame

    while @state == :midgame
      @board.display_board
      puts "\n#{@players[0].playerName}'s score: #{@players[0].score}"
      puts "Enter 3 card indices (e.g. 1 2 3) to select a set,"
      puts "or enter 'd' to draw 3 more cards (max 18 on board)."
      puts "Current deck has #{@deck.card_count} cards left."
      print "> "
      input = gets.chomp.strip

      # Handle quit
      if input.downcase == 'q'
        puts "Quitting game. #{@players[0].playerName}'s final score: #{@players[0].score}"
        quit_game
        next
      end

      # Handle draw request
      if input.downcase == 'd'
        if @board.card_count >= 18
          puts "Board already has #{@board.card_count} cards (max 18). Cannot draw more."
        elsif @deck.empty?
          puts "No cards left in the deck to draw."
        else
          new_cards = @deck.draw(3)
          # add new cards to the board's visible cards
          @board.visible_cards.concat(new_cards)
          puts "Drew #{new_cards.length} card(s):"
          # for each new card, print it out tell the user what they drew
          new_cards.each { |c| puts "  #{c}" } 
        end
        # in invalid input case, skip the rest of the loop and prompt again, same for all nexts below 6/1/2026 by hongle chen
        next
      end

      # Handle cheat
      if input == 'CHEAT'
        cheatOutput = @board.cheat()
        if @board.cheat.length == 3
          print "\nHere are indexes of three cards that form a set: #{cheatOutput}\n"
        else 
          puts "There is not set on the board."
        end
        next
      end

      next if !valid_card_selection? input

      indices = input.split.map{|s| s.to_i}
      # out put the selection to player what they selected last round
      # # i-1 because display are 1-12, but index is 0-11
      selected = indices.map { |i| @board.visible_cards[i - 1] }
      puts "\nYou selected:"
       # for each selected card, print out the index and the card itself 
      selected.each_with_index { |c, i| puts "  #{indices[i]}: #{c}" }

      if @validator.validateCards?(selected[0], selected[1], selected[2])
        puts "Valid set! 3 points."
        @players[0].addPoint(3)
        # remove the selected cards from the board's visible cards if they are valid set
        @board.visible_cards.reject! { |c| selected.include?(c) } 
        # Refill to 12 if deck has cards and board fell below 12
        while @board.visible_cards.length < 12 && !@deck.empty?
          @board.visible_cards.concat(@deck.draw(3))
        end
        puts "#{@players[0].playerName}'s score: #{@players[0].score}"
        if @board.visible_cards.empty? && @deck.empty?
          puts "\nNo more cards! Game over. #{@players[0].playerName}'s final score: #{@players[0].score}"
          @state = :postgame
        end
      else
        puts "Not a valid set. Try again. Point deducted."
        @players[0].deductPoint(1)
      end
    end
  end

  # Created 6/1/26 by Hongle Chen and Michael Cintron 
  # Check if the user provided an input that is three integers, that are indexes of the cards on the board.
  # 
  # userInput [string] the string that comes from the user's (expected to be already chomped)
  # 
  # return [true] if the userInput can be split into 3 integers that are within the index bounds of the board's deck.
  def valid_card_selection? userInput
    indices = userInput.split.map{|s| s.to_i}
    # Validate index range
    max_index = @board.visible_cards.length
    unless indices.all? { |i| i >= 1 && i <= max_index }
      puts "Indices must be between 1 and #{max_index}."
      return false
    end

    if indices.uniq.length != 3
      puts "Please enter exactly 3 unique indices."
      return false
    end
    
    true
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