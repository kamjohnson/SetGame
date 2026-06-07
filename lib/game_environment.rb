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
Edited 6/2/26 by Michael Cintron - Moved card input validation into its own method
Edited 6/6/2026 by Joon Yoo - Added tutorial mode message and disabled score display and point changes
Edited 6/6/2026 by Joon Yoo - Removed unused pause methods (pause_game, handle_pause_selection, pause_action)
Edited 6/6/2026 by Joon Yoo - Updated initialize to accept an array of players for multiplayer mode
Edited 6/6/2026 by Joon Yoo - Created new methods for multiplayer mode (select_current_player, display_multiplayer_score)
Edited 6/6/2026 by Joon Yoo - Updated start_game to support multiplayer and score display
Edited 6/6/2026 by Joon Yoo - Updated scoring to apply points to the current player
=end
require_relative 'deck'
require_relative 'board'
require_relative 'set_validator'
require_relative 'player'

class GameEnvironment

  # Created 5/25/2026 by Kameron Johnson
  # Modified 5/31/26 by Michael Cintron - moved deck shuffling here so the board gets
  #   the shuffled deck
  # Modified 6/1/2026 by Joon Yoo - Added player ID and name parameters
  #   so GameEnvironment can create a player using user input from main.
  #   Also removed the duplicated statement: @state, @mode = :pregame, nil
  # Modified 6/5/2026 by Kameron Johnson - added :board to attr_reader so gui can read board
  # Modified 6/6/2026 by Joon Yoo - Updated initialize to accept an array of players
  # Runs automatically when a new GameEnvironment object is created
  attr_reader :state, :mode, :board, :deck
  def initialize players = [Player.new(1, "Player 1")]
    @deck = Deck.new
    @deck.shuffle!
    @board = Board.new @deck
    @players = players
    @validator = SetValidator.new
    @state, @mode = :pregame, nil
  end

  # Created 5/25/2026 by Kameron Johnson
  # Modified 5/28/2026 by Michael Cintron - corrected shuffle! call
  # Modified 5/31/26 by Michael Cintron - Moved shuffle! call to initialize
  # Modified 5/31/26 - Replaced test draw with interactive player input loop
  # Modified 6/1/26 by Hongle Chen - Implemented game loop.
  # Modified 6/1/26 by Michael Cintron - clean up comments and moved card validation into its own function
  # Modified 6/1/2026 by Joon Yoo - Added the player’s name to the score output statement.
  # Modified 6/1/2026 by Joon Yoo - Adjusted the points awarded for finding a valid set to 3 points.
  # Modified 6/1/2026 by Joon Yoo - Added a feature that deducts 1 point when an invalid set is found.
  # Modified 6/6/2026 by Joon Yoo - Added a tutorial mode message
  # Modified 6/6/2026 by Joon Yoo - Updated tutorial mode to hide score output and prevent point addition and deduction
  # Modified 6/6/2026 by Joon Yoo - Added multiplayer current player selection
  # Modified 6/6/2026 by Joon Yoo - Updated score changes to use the current player
  # Modified 6/6/2026 by Joon Yoo - Added multiplayer final score display
  # Starts the game, then enters the main game loop where the player selects cards or draws.
  def start_game
    # return if @state == :midgame
    @state = :midgame

    if @mode == :tutorial
      puts "-----------------------------------------------------------------"
      puts "|  This is tutorial mode. No points will be added or deducted.  |"
      puts "-----------------------------------------------------------------"
    end

    while @state == :midgame
      @board.display_board
      current_player = nil

      # Selects the current player in multiplayer mode, otherwise uses the single player.
      if @mode == :multiplayer then current_player = select_current_player
      else
        current_player = @players[0]
        puts "#{current_player.playerName}'s score: #{current_player.score}" unless @mode == :tutorial
      end

      puts "\nEnter 3 card indices (e.g. 1 2 3) to select a set,"
      puts "or enter 'd' to draw 3 more cards (max 18 on board)."
      puts "Current deck has #{@deck.card_count} cards left."
      print "> "
      input = gets.chomp.strip

      # Handle quit
      if input.downcase == 'q'
        # Displays all player scores when quitting multiplayer mode.
        if @mode == :multiplayer then puts "\nFinal scores:"; display_multiplayer_score
        else
          puts "Quitting game. #{current_player.playerName}'s final score: #{current_player.score}" unless @mode == :tutorial
        end
        
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
        puts cheat
        next
      end

      # Go to the next loop if the user did not provide 3 card indices
      next if !valid_card_selection? input

      indices = input.split.map{|s| s.to_i}
      # out put the selection to player what they selected last round
      # i-1 because display are 1-12, but index is 0-11
      selected = indices.map { |i| @board.visible_cards[i - 1] }
      puts "\n#{current_player.playerName} selected:"
       # for each selected card, print out the index and the card itself 
      selected.each_with_index { |c, i| puts "  #{indices[i]}: #{c}" }

      if @validator.validateCards?(selected[0], selected[1], selected[2])
        # Adds points to the current player unless the game is in tutorial mode.
        if @mode == :tutorial then puts "\nValid set!"
        else puts "\nValid set! 3 points."; current_player.addPoint(3) end
        
        # remove the selected cards from the board's visible cards if they are valid set
        @board.visible_cards.reject! { |c| selected.include?(c) } 
        # Refill to 12 if deck has cards and board fell below 12
        while @board.visible_cards.length < 12 && !@deck.empty?
          draw_three_cards
        end
        puts "#{current_player.playerName}'s score: #{current_player.score}" unless @mode == :tutorial
        if @board.visible_cards.empty? && @deck.empty?
          if @mode == :multiplayer
            puts "\nNo more cards! Game over.\nFinal scores:"
            display_multiplayer_score
          else
            puts "\nNo more cards! Game over. #{current_player.playerName}'s final score: #{current_player.score}" unless @mode == :tutorial
          end
          @state = :postgame
        end
      else
        # Deducts points from the current player unless the game is in tutorial mode.
        if @mode == :tutorial then puts "\nNot a valid set. Try again."
        else puts "\nNot a valid set. Try again. Point deducted."; current_player.deductPoint(1) end
      end
    end
  end

  # Created 6/6/26 by Micheal Cintron - Moved cheat logic into own function
  # Provide a pretty string telling the 3 cards to make a set or if there is not set. 
  #  
  # return [string] telling what are three cards that make a set or a if there are no sets on the board.
  def cheat
    # Get array of 3 indices or empty array if there is no set
    cheatOutput = @board.cheat()
    if @board.cheat.length == 3
      return "Try cards: #{cheatOutput[0]}, #{cheatOutput[1]}, and #{cheatOutput[2]}"
    else 
      return "There is no set on the board."
    end
  end

  # Created 6/1/26 by Hongle Chen and Michael Cintron 
  # Modified 6/2/26 by Michael Cintron - improved terse-ness and added single line comments
  # Check if the user provided an input that is three integers, that are indexes of the cards on the board.
  # 
  # userInput [string] the string that comes from the user's (expected to be already chomped)
  # 
  # return [true] if the userInput can be split into 3 integers that are within the index bounds of the board's deck.
  def valid_card_selection? userInput
    # take user input, split it, and convert each split-string into an integer
    indices = userInput.split.map{|s| s.to_i}

    # Check if the indices given are with the bounds of 1 and <# of cards on board>
    max_index = @board.visible_cards.length
    unless indices.all? { |i| i >= 1 && i <= max_index }
      puts "Indices must be between 1 and #{max_index}."
      return false
    end

    # Check if the user provided 3 unique indices
    if indices.uniq.length != 3; puts "Please enter exactly 3 unique indices."; return false end
    
    # return true if all checks passed
    true
  end

  # Created 5/25/2026 by Kameron Johnson
  # Ends the game
  def quit_game; @state = :postgame end
  
  # Created 5/25/2026 by Kameron Johnson
  # Allows the user to select a game mode
  def choose_game_mode(mode); @mode = mode end

  # Created 6/6/26 Michael Cintron
  # draw 3 cards from the deck and put them onto the board
  #
  # return [array] all board with 3 new cards
  def draw_three_cards 
    @board.visible_cards.concat @deck.draw 3 if @deck.card_count > 0 
  end

  # Created 6/6/2026 by Joon Yoo
  # Displays all players in multiplayer mode and returns the player selected
  # for the current turn.
  #
  # @return [Player] the selected player for the current turn
  def select_current_player
    # Displays all players and their current scores.
    puts "- Players -"
    display_multiplayer_score
    current_player = nil
    
    # Keeps asking until the user enters a valid player number.
    until current_player
      print "\nEnter player number if you find set\n> "
      number = gets.chomp.strip.to_i

      if number >= 1 && number <= @players.length then current_player = @players[number - 1]
      else puts "Invalid player number." end
    end
    current_player
  end

  # Created 6/6/2026 by Joon Yoo
  # Displays each player's number, name, ID, and score.
  #
  # @return [nil]
  def display_multiplayer_score
    # Uses each player's array index as the displayed player number.
    @players.each_index do |i|
      player = @players[i]
      puts "#{i + 1}. #{player.playerName} | ID: #{player.playerID} | Score: #{player.score}"
    end
  end
end