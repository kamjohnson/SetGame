=begin 
File Created 6/1/2026 by Kameron Johnson: Initial GUI setup using Glimmer
File Edited 6/4/2026 by Kameron Johnson: switched to ruby2d for better graphics support and easier integration with game logic.
File Edited 6/5/2026 by Kameron Johnson: Implemented Ruby2D UI layout including window configuration, custom Button class with 
  auto-centering text, layout positioning, and static dashboard controls (Hint, Draw, Finish, Scoreboard). 
  Created 81 card '.png's for the gui.
  Implemented
File Edited 6/6/26 by Michael Cintron - implemented hint functionality
=end

require 'ruby2d'
require_relative 'player'
require_relative 'board'
require_relative 'card_assets'
require_relative 'game_environment'
require_relative 'set_validator'
require_relative 'card'
require_relative 'deck'

#CONSTANTS
WINDOW_WIDTH, WINDOW_HEIGHT = 980, 740
BACKGROUND_COLOR = '#8882AA'
SCOREBOARD_START_X = 338
DASHBOARD_START_X, DASHBOARD_START_Y, DASHBOARD_PADDING =  35, 620, 35
BTN_WIDTH, BTN_HEIGHT = 100, 60
TEXT_COLOR = 'white'
BTN_COLOR = '#1B0A36'

############ CARD GRID LAYOUT CONSTANTS
CARD_WIDTH = 100
CARD_HEIGHT = 140
GRID_START_X = 35
GRID_START_Y = 70
X_SPACING = 145       # CARD_WIDTH + horizontal gap (110 + 20)
Y_SPACING = 185       # CARD_HEIGHT + vertical gap (160 + 25)
CARDS_PER_ROW = 6

# Set up the window
set title: "Set Game", width: WINDOW_WIDTH, height: WINDOW_HEIGHT
set background: BACKGROUND_COLOR

background_image = Image.new(
  'assets/a5.png',
  x: 0,
  y: 0,
  width: WINDOW_WIDTH,
  height: WINDOW_HEIGHT,
  z: -10
)

qaq_image = Image.new(
  'assets/as.png',
  x: 870,
  y: 10,
  width: 100,
  height: 100,
  z: 3
)


class Button
  attr_reader :rect, :text_obj, :x, :y, :width, :height
  
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
  def initialize(x:, y:, width:, height:, text:, size: 22, style: 'bold')
    # Store button properties for potential future use (e.g., click detection) 6/5/2026 Hongle Chen
    @x = x
    @y = y
    @width = width
    @height = height



    @rect = Rectangle.new(
      x:x, y: y,
      width: width, height: height,
      color: BTN_COLOR,
      z: 5  
      # Ensure buttons are above cards in rendering order
    )
    
    # Calculate center of button for text positioning
    text_x_pos = x + (width / 2) - (text.length * (size / 4.0))
    text_y_pos = y + (height / 2) - (size / 2.0)

    @text_obj = Text.new(
      text,
      style: style,
      x: text_x_pos, y: text_y_pos,
      size: size, color: TEXT_COLOR,
      z: 6
    )
  end

  # 6/5/2026 Hongle Chen - method to check if a given mouse click is within the bounds of this button's rectangle
  # 
  # @param mouse_x [Integer] X-coordinate of mouse click
  # @param mouse_y [Integer] Y-coordinate of mouse click
  # @return [Boolean] true if click is within button bounds, false otherwise
  def contains_point?(mouse_x, mouse_y)
    mouse_x >= @x && mouse_x <= @x + @width &&
      mouse_y >= @y && mouse_y <= @y + @height
  end

end




########REMOVE BEFORE COMMIT################
class VisualCard
  attr_reader :card_data, :image_element, :x, :y

  # Created by Kameron Johnson on 6/5/2026
  # Initializes a visual representation of a card with its image
  # 
  # @param card_data [Card] The logical card object containing number, color, shape, pattern
  # @param x [Integer] X-coordinate for card placement on grid
  # @param y [Integer] Y-coordinate for card placement on grid
  # @return [void] Creates and displays image element on screen
  def initialize(card_data, x, y)
    @card_data = card_data
    # 6/5/2026 Hongle Chen - add selected state to track if the card is currently selected by the player
    @x = x
    @y = y
    @selected = false
    @highlight = nil

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



  
  # 6/5/2026 Hongle Chen - method to check if a given mouse click is within the bounds of this card's image
  # 
  # @param mouse_x [Integer] X-coordinate of mouse click
  # @param mouse_y [Integer] Y-coordinate of mouse click
  # @return [Boolean] true if click is within card bounds, false otherwise
  def contains_point?(mouse_x, mouse_y)
    mouse_x >= @x && mouse_x <= @x + CARD_WIDTH &&
      mouse_y >= @y && mouse_y <= @y + CARD_HEIGHT
  end

  # 6/5/2026 Hongle Chen - method to toggle the selected state of the card and update the highlight visibility accordingly
  def selected?
    @selected
  end

  # 6/5/2026 Hongle Chen - method to set the card as selected and show the highlight
  def select
    return if @selected

    @selected = true
    @highlight = Rectangle.new(
      x: @x - 4,
      y: @y - 4,
      width: CARD_WIDTH + 8,
      height: CARD_HEIGHT + 8,
      color: '#F7E58C',
      z: 1
    )
  end

  # 6/5/2026 Hongle Chen - method to set the card as deselected and hide the highlight
  def deselect
    @selected = false
    if @highlight
      @highlight.remove
      @highlight = nil
    end
  end

  # 6/5/2026 Hongle Chen - method to toggle the selected state of the card when clicked
  def toggle_selection
    @selected ? deselect : select
  end

  # 6/5/2026 Hongle Chen - method to remove the card's image and highlight from the screen when the card is removed from the board
  # Created by Kameron Johnson on 6/5/2026
  # Removes the visual card from the screen
  # 
  # @return [void] Removes the image element from the Ruby2D window
  def remove
    @highlight.remove if @highlight
    @image_element.remove
  end
end


## Array to keep track of the currently rendered Ruby2D image elements
@active_visual_cards = []
# 6/5/2026 Hongle Chen - Array to track which cards are currently selected by the player, used for validating sets and providing visual feedback
@selected_cards = []
@popup_elements = []
@popup_button = nil
@popup_active = false
@score = 0

game_env = GameEnvironment.new 
validator = SetValidator.new

# Created by Kameron Johnson on 6/5/2026
# Renders all board cards to the Ruby2D grid layout
# 
# @param current_board_cards [Array<Card>] Array of logical card objects currently on board
# @return [void] Updates @active_visual_cards with new card images displayed on screen
def render_board(current_board_cards)
  # Clear any existing card images from the screen first
  @active_visual_cards.each(&:remove)
  @active_visual_cards.clear
  @selected_cards.clear
  # 6/5/2026 Hongle Chen - Clear selected cards tracking when re-rendering the board to avoid stale selections

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



# 6/5/2026 Hongle Chen - method to close the currently active popup by removing all its elements from the screen and resetting tracking variables
# 
# @return [void] Removes all popup elements and resets tracking variables
def close_popup
  @popup_elements.each { |el| el.remove rescue nil }
  @popup_elements = []
  @popup_button = nil
  @popup_active = false
end


# 6/5/2026 Hongle Chen - method to display a popup message on the screen, used for feedback like "Set is valid!" or "No sets available!"
# 
# @param message [String] The message to display in the popup
# @param color [String] Background color of the popup (default: green)
# @return [void] Creates and displays a popup with the given message and an OK button to close it
def show_popup(message, color = '#27ae60')
  close_popup

  bg = Image.new(
    'assets/a4.png',
    x: 180, y: 190,
    width: 620, height: 240,
    z: 20
  )

  text = Text.new(
    message,
    x: 280, y: 280,
    size: 24,
    color: 'black',
    z: 21
  )

  ok_button = Button.new(
    x: 430, y: 340,
    width: 120, height: 45,
    text: "OK",
    size: 18
  )
  ok_button.rect.z = 22
  ok_button.text_obj.z = 23

  @popup_elements = [bg, text, ok_button.rect, ok_button.text_obj]
  @popup_button = ok_button
  @popup_active = true
end


#=======================================UI Setup========================================================================
#update 6/5/2026 Hongle Chen - Define button positions 
BOTTOM_BUTTON_COUNT = 4
BOTTOM_SIDE_MARGIN = 35
CAT_WIDTH = 210
CAT_HEIGHT = 210
BUTTON_Y = 640
CAT_Y = BUTTON_Y - 98
BUTTON_OVERLAP = 18

total_button_width = BOTTOM_BUTTON_COUNT * BTN_WIDTH
available_space = WINDOW_WIDTH - (2 * BOTTOM_SIDE_MARGIN) - total_button_width
button_gap = available_space / (BOTTOM_BUTTON_COUNT - 1)

hint_btn_x_pos    = BOTTOM_SIDE_MARGIN
draw_btn_x_pos    = hint_btn_x_pos + BTN_WIDTH + button_gap
confirm_btn_x_pos = draw_btn_x_pos + BTN_WIDTH + button_gap
finish_btn_x_pos  = confirm_btn_x_pos + BTN_WIDTH + button_gap

draw_btn_x_pos    = draw_btn_x_pos - BUTTON_OVERLAP
confirm_btn_x_pos = confirm_btn_x_pos - BUTTON_OVERLAP
finish_btn_x_pos  = finish_btn_x_pos - BUTTON_OVERLAP

cat_draw = Image.new(
  'assets/a6.png',
  x: draw_btn_x_pos - 110,
  y: CAT_Y,
  width: CAT_WIDTH,
  height: CAT_HEIGHT,
  z: 4
)

cat_confirm = Image.new(
  'assets/a6.png',
  x: confirm_btn_x_pos - 110,
  y: CAT_Y,
  width: CAT_WIDTH,
  height: CAT_HEIGHT,
  z: 4
)

cat_finish = Image.new(
  'assets/a6.png',
  x: finish_btn_x_pos - 110,
  y: CAT_Y,
  width: CAT_WIDTH,
  height: CAT_HEIGHT,
  z: 4
)

# just for testing 
player_name = "Player 1"

# 6/5/2026 Hongle Chen - Create static dashboard elements for deck count and player score, which will be updated dynamically during gameplay
deck_label = Text.new(
  "Deck Left:",
  style: 'bold',
  size: 24,
  x: 35,
  y: 15,
  color: '#1B0A36',
  z: 6
)

deck_count_text = Text.new(
  game_env.deck.card_count.to_s,
  style: 'bold',
  size: 24,
  x: 170,
  y: 15,
  color: '#1B0A36',
  z: 6
)

#TODO: pass in player name
scoreboard_name = Text.new(
  "#{player_name} Score :",
  style: 'bold',
  size: 24,
  x: 400, y: 15,
  color: '#1B0A36',
  z: 6
)


#TODO: pass in player score
scoreboard_score = Text.new(
  @score.to_s,
  style: 'bold',
  size: 24,
  x: 600, y: 15,
  color: '#1B0A36',
  z: 6
)


# to be developed later
hint_btn = Button.new x: hint_btn_x_pos, y: DASHBOARD_START_Y, width: BTN_WIDTH,
height: BTN_HEIGHT, text: "Hint"

draw_btn = Button.new x: draw_btn_x_pos, y: DASHBOARD_START_Y, width: BTN_WIDTH,
height: BTN_HEIGHT, text: "Draw"

finish_btn = Button.new x: finish_btn_x_pos, y: DASHBOARD_START_Y, width: BTN_WIDTH,
height: BTN_HEIGHT, text: "FINISH"

confirm_btn = Button.new x: confirm_btn_x_pos, y: DASHBOARD_START_Y,
width: BTN_WIDTH, height: BTN_HEIGHT, text: "Confirm", size: 22

#==============================Render Initial Board===============================================================


# Render the cards onto the grid after the environment and methods are established
render_board(game_env.board.visible_cards)

# =======================================Draw Cards===============================================================
# 6/5/2026 Hongle Chen - method to update the deck count display on the dashboard whenever cards are drawn from the deck
def update_deck_count(deck_count_text, game_env)
  deck_count_text.text = game_env.deck.card_count.to_s
end

# 6/5/2026 Hongle Chen - method to replace a valid set of cards on the board with new cards drawn from the deck, 
#   or remove them if the deck is empty, then re-render the board
def replace_valid_set(game_env, selected_card_objects, deck_count_text)
  indices = selected_card_objects.map do |card|
    game_env.board.visible_cards.index(card)
  end.compact.sort.reverse

  indices.each do |index|
    if game_env.deck.card_count > 0
      drawn_card = game_env.deck.draw(1).first
      game_env.board.visible_cards[index] = drawn_card if drawn_card
    else
      game_env.board.visible_cards.delete_at(index)
    end
  end

  update_deck_count(deck_count_text, game_env)
  render_board(game_env.board.visible_cards)
end

# 6/5/2026 Hongle Chen - method to draw 3 additional cards from the deck onto the board and re-render the layout
def draw_three_cards(game_env, deck_count_text)
  return if game_env.deck.card_count <= 0

  max_cards_on_board = 18

  available_slots = max_cards_on_board - game_env.board.visible_cards.length

  return if available_slots <= 0

  cards_to_draw = [3, game_env.deck.card_count].min
  new_cards = game_env.deck.draw(cards_to_draw)

  game_env.board.visible_cards.concat(new_cards)

  update_deck_count(deck_count_text, game_env)
  render_board(game_env.board.visible_cards)
end
# =================================================================================================================


# ====================== Handle mouse clicks for card selection and button interactions ===========================

on :mouse_down do |event|
  mouse_x = event.x
  mouse_y = event.y

  if @popup_active
    if @popup_button && @popup_button.contains_point?(mouse_x, mouse_y)
      close_popup
    end
    next
  end

  if hint_btn.contains_point?(mouse_x, mouse_y) then show_popup(game_env.cheat) end

  if confirm_btn.contains_point?(mouse_x, mouse_y)
    if @selected_cards.length != 3
      show_popup("Please select exactly 3 cards", '#c0392b')
    else
      selected_card_objects = @selected_cards.map(&:card_data)

      if validator.validateCards?(
          selected_card_objects[0],
          selected_card_objects[1],
          selected_card_objects[2]
        )
        replace_valid_set(game_env, selected_card_objects, deck_count_text)
        @score += 1
        scoreboard_score.text = @score.to_s
        @selected_cards.each(&:deselect)
        @selected_cards.clear    
        show_popup("Valid Set! Score +1", '#27ae60')

      else
        @selected_cards.each(&:deselect)
        @selected_cards.clear
        show_popup("Not a valid Set.", '#c0392b')
      end
    end
    next
  end

  # 6/5/2026 Hongle Chen -Draw button, draw three additional cards from the deck
  if draw_btn.contains_point?(mouse_x, mouse_y)
    draw_three_cards(game_env, deck_count_text)
    next
  end

  # 6/5/2026 Hongle Chen - Check if the click was on the Finish button, and if so, exit the application immediately
  #   click finish to exit the game and window
  #   don't use x to exit window, it will continue run in memory
  
  if finish_btn.contains_point?(mouse_x, mouse_y)
    Thread.new do
      sleep 0.05
      Process.exit!(0)
    end
    next
  end
  
  clicked_card = @active_visual_cards.find { |vc| vc.contains_point?(mouse_x, mouse_y) }
# 6/5/2026 Hongle Chen - Check if the click was on a card, and if so toggle its selection state 
# and update the @selected_cards tracking array accordingly
  if clicked_card
    if clicked_card.selected?
      clicked_card.deselect
      @selected_cards.delete(clicked_card)
    else
      if @selected_cards.length < 3
        clicked_card.select
        @selected_cards << clicked_card
      end
    end
  end
end
# =======================================================================================================


# update do
# end



show # Start the Ruby2D application loop to display the window and handle events

