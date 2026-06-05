=begin 
File Created 6/1/2026 by Kameron Johnson: Initial GUI setup using Glimmer
File Edited 6/4/2026 by Kameron Johnson: switched to ruby2d for better graphics support and easier integration with game logic.
File Edited 6/5/2026 by Kameron Johnson: Implemented Ruby2D UI layout including window configuration, custom Button class with 
  auto-centering text, layout positioning, and static dashboard controls (Hint, Draw, Finish, Scoreboard). 
  Created 81 card '.png's for the gui.
  Implemented
=end

require 'ruby2d'
require_relative 'player'
require_relative 'board'
require_relative 'card_assets'
require_relative 'game_environment'

#CONSTANTS
WINDOW_WIDTH, WINDOW_HEIGHT = 980, 700
BACKGROUND_COLOR = '#8882AA'
SCOREBOARD_START_X = 338
DASHBOARD_START_X, DASHBOARD_START_Y, DASHBOARD_PADDING =  35, 603, 35
BTN_WIDTH, BTN_HEIGHT = 100, 60
TEXT_COLOR = 'white'
BTN_COLOR = '#1B0A36'

############ CARD GRID LAYOUT CONSTANTS
CARD_WIDTH = 110
CARD_HEIGHT = 150
GRID_START_X = 80
GRID_START_Y = 50
X_SPACING = 150       # CARD_WIDTH + horizontal gap (110 + 20)
Y_SPACING = 180       # CARD_HEIGHT + vertical gap (160 + 25)
CARDS_PER_ROW = 4

# Set up the window
set title: "Set Game", width: WINDOW_WIDTH, height: WINDOW_HEIGHT
set background: BACKGROUND_COLOR


class Button
  attr_reader :rect, :text_obj
  
  # Created by Kameron Johnson on 6/5/2026
  # Initializes a new Button UI element with auto-centering text
  # 
  # @param x [Integer] X-coordinate of button's top-left corner
  # @param y [Integer] Y-coordinate of button's top-left corner
  # @param width [Integer] Width of button in pixels
  # @param height [Integer] Height of button in pixels
  # @param text [String] Text to display on button
  # @param size [Integer] Font size of button text (default: 12)
  # @param style [String] Font style (default: 'bold')
  # @return [void] Creates rectangle and text objects as instance variables
  def initialize(x:, y:, width:, height:, text:, size: 12, style: 'bold')
    @rect = Rectangle.new(
      x:x, y: y,
      width: width, height: height,
      color: BTN_COLOR
    )
  
    # Calculate center of button for text positioning
    text_x_pos = x + (width / 2) - (text.length * (size / 4.0))
    text_y_pos = y + (height / 2) - (text.length * (size / 4.0))

    @text_obj = Text.new(
      text,
      style: style,
      x: text_x_pos, y: text_y_pos,
      size: size, color: TEXT_COLOR
    )
  end
end

########REMOVE BEFORE COMMIT################
class VisualCard
  attr_reader :card_data, :image_element

  # Created by Kameron Johnson on 6/5/2026
  # Initializes a visual representation of a card with its image
  # 
  # @param card_data [Card] The logical card object containing number, color, shape, pattern
  # @param x [Integer] X-coordinate for card placement on grid
  # @param y [Integer] Y-coordinate for card placement on grid
  # @return [void] Creates and displays image element on screen
  def initialize(card_data, x, y)
    @card_data = card_data
    
    # Map card attributes to image file path
    key = [card_data.number, card_data.color, card_data.shape, card_data.pattern]
    file_name = CardAssets::MAP[key]

    full_path = "assets/#{file_name}"

    @image_element = Image.new(
      full_path,
      x: x, y: y,
      width: CARD_WIDTH, height: CARD_HEIGHT,
      z: 2
    )
  end

  # Created by Kameron Johnson on 6/5/2026
  # Removes the visual card from the screen
  # 
  # @return [void] Removes the image element from the Ruby2D window
  def remove
    @image_element.remove
  end
end

## Array to keep track of the currently rendered Ruby2D image elements
@active_visual_cards = []

# Created by Kameron Johnson on 6/5/2026
# Renders all board cards to the Ruby2D grid layout
# 
# @param current_board_cards [Array<Card>] Array of logical card objects currently on board
# @return [void] Updates @active_visual_cards with new card images displayed on screen
def render_board(current_board_cards)
  # Clear any existing card images from the screen first
  @active_visual_cards.each(&:remove)
  @active_visual_cards.clear

  # Loop through the actual logical card objects on the board
  current_board_cards.each_with_index do |card, index|
    # Grid calculation: row is (index / 4), column is (index % 4)
    row = index / CARDS_PER_ROW
    col = index % CARDS_PER_ROW

    x_pos = GRID_START_X + (col * X_SPACING)
    y_pos = GRID_START_Y + (row * Y_SPACING)

    # Instantiate the visual element, which automatically draws it to the window
    @active_visual_cards << VisualCard.new(card, x_pos, y_pos)
  end
end

#UI Setup
hint_btn_x_pos = DASHBOARD_START_X
draw_btn_x_pos = hint_btn_x_pos + (BTN_WIDTH + DASHBOARD_PADDING)
finish_btn_x_pos = WINDOW_WIDTH - DASHBOARD_PADDING - BTN_WIDTH

scoreboard = Rectangle.new(
  x: SCOREBOARD_START_X, y: DASHBOARD_START_Y,
  width: 4 * BTN_WIDTH, height: BTN_HEIGHT,
  color: BTN_COLOR
)

#TODO: pass in player name
scoreboard_name = Text.new(
  "variable player's Score",
  style: 'bold',
  size: 12,
  x: SCOREBOARD_START_X + 10, y: DASHBOARD_START_Y + 5,
)

#TODO: pass in player score
scoreboard_score = Text.new(
  "score",
  style: 'bold',
  size: 24,
  x:  (1.5 * SCOREBOARD_START_X).to_i , y:DASHBOARD_START_Y + 10,
  color: TEXT_COLOR
)

hint_btn = Button.new x: hint_btn_x_pos, y: DASHBOARD_START_Y, width: BTN_WIDTH,
height: BTN_HEIGHT, text: "Hint"

draw_btn = Button.new x: draw_btn_x_pos, y: DASHBOARD_START_Y, width: BTN_WIDTH,
height: BTN_HEIGHT, text: "Draw"

finish_btn = Button.new x: finish_btn_x_pos, y: DASHBOARD_START_Y, width: BTN_WIDTH,
height: BTN_HEIGHT, text: "FINISH"


game_env = GameEnvironment.new 
game_env.start_game

# Render the cards onto the grid after the environment and methods are established
render_board(game_env.board.visible_cards)

update do
  # Runs every frame — use for animation/game logic
end

show  # Opens the window — always last