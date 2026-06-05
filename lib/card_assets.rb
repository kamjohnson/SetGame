=begin
File Created 6/5/2026 by Kameron Johnson - Module to hold all of the GUI cards and their card valies
=end
module CardAssets
  #Created 6/5/2026 by Kameron Johnson 
  #
  # MAP: Hash mapping card attribute arrays to image filenames
  # @type [Hash<Array(Symbol, Symbol, Symbol, Symbol), String>]
  # Key format: [number (1-3), color (:red/:green/:purple), shape (:oval/:diamond/:squiggle), pattern (:solid/:striped/:open)]
  # Value format: String filename (e.g., "Frame 34.png")
  # Total 81 combinations for the Set Deck
  MAP = {
    # NUMBER: 1
    # Red
    [1, :red, :oval, :solid] => "Frame 34.png",
    [1, :red, :oval, :striped] => "Frame 31.png",
    [1, :red, :oval, :open] => "Frame 37.png",
    [1, :red, :diamond, :solid] => "Frame 16.png",
    [1, :red, :diamond, :striped] => "Frame 13.png",
    [1, :red, :diamond, :open] => "Frame 19.png",
    [1, :red, :squiggle, :solid] => "Frame 73.png",
    [1, :red, :squiggle, :striped] => "Frame 69.png",
    [1, :red, :squiggle, :open] => "Frame 75.png",

    # Green
    [1, :green, :oval, :solid] => "Frame 55.png",
    [1, :green, :oval, :striped] => "Frame 51.png",
    [1, :green, :oval, :open] => "Frame 57.png",
    [1, :green, :diamond, :solid] => "Frame 25.png",
    [1, :green, :diamond, :striped] => "Frame 22.png",
    [1, :green, :diamond, :open] => "Frame 28.png",
    [1, :green, :squiggle, :solid] => "Frame 64.png",
    [1, :green, :squiggle, :striped] => "Frame 60.png",
    [1, :green, :squiggle, :open] => "Frame 66.png",

    # Purple
    [1, :purple, :oval, :solid] => "Frame 46.png",
    [1, :purple, :oval, :striped] => "Frame 42.png",
    [1, :purple, :oval, :open] => "Frame 48.png",
    [1, :purple, :diamond, :solid] => "Frame 9.png",
    [1, :purple, :diamond, :striped] => "Frame 2.png",
    [1, :purple, :diamond, :open] => "Frame 7.png",
    [1, :purple, :squiggle, :solid] => "Frame 82.png",
    [1, :purple, :squiggle, :striped] => "Frame 78.png",
    [1, :purple, :squiggle, :open] => "Frame 84.png",


    # NUMBER: 2
    # Red
    [2, :red, :oval, :solid] => "Frame 35.png",
    [2, :red, :oval, :striped] => "Frame 38.png",
    [2, :red, :oval, :open] => "Frame 40.png",
    [2, :red, :diamond, :solid] => "Frame 17.png",
    [2, :red, :diamond, :striped] => "Frame 20.png",
    [2, :red, :diamond, :open] => "Frame 18.png",
    [2, :red, :squiggle, :solid] => "Frame 74.png",
    [2, :red, :squiggle, :striped] => "Frame 70.png",
    [2, :red, :squiggle, :open] => "Frame 76.png",

    # Green
    [2, :green, :oval, :solid] => "Frame 56.png",
    [2, :green, :oval, :striped] => "Frame 52.png",
    [2, :green, :oval, :open] => "Frame 58.png",
    [2, :green, :diamond, :solid] => "Frame 26.png",
    [2, :green, :diamond, :striped] => "Frame 29.png",
    [2, :green, :diamond, :open] => "Frame 27.png",
    [2, :green, :squiggle, :solid] => "Frame 65.png",
    [2, :green, :squiggle, :striped] => "Frame 61.png",
    [2, :green, :squiggle, :open] => "Frame 67.png",

    # Purple
    [2, :purple, :oval, :solid] => "Frame 47.png",
    [2, :purple, :oval, :striped] => "Frame 43.png",
    [2, :purple, :oval, :open] => "Frame 49.png",
    [2, :purple, :diamond, :solid] => "Frame 11.png",
    [2, :purple, :diamond, :striped] => "Frame 3.png",
    [2, :purple, :diamond, :open] => "Frame 6.png",
    [2, :purple, :squiggle, :solid] => "Frame 83.png",
    [2, :purple, :squiggle, :striped] => "Frame 79.png",
    [2, :purple, :squiggle, :open] => "Frame 85.png",


    # NUMBER: 3
    # Red
    [3, :red, :oval, :solid] => "Frame 33.png",
    [3, :red, :oval, :striped] => "Frame 39.png",
    [3, :red, :oval, :open] => "Frame 41.png",
    [3, :red, :diamond, :solid] => "Frame 15.png",
    [3, :red, :diamond, :striped] => "Frame 12.png",
    [3, :red, :diamond, :open] => "Frame 14.png",
    [3, :red, :squiggle, :solid] => "Frame 72.png",
    [3, :red, :squiggle, :striped] => "Frame 71.png",
    [3, :red, :squiggle, :open] => "Frame 77.png",

    # Green
    [3, :green, :oval, :solid] => "Frame 54.png",
    [3, :green, :oval, :striped] => "Frame 53.png",
    [3, :green, :oval, :open] => "Frame 59.png",
    [3, :green, :diamond, :solid] => "Frame 24.png",
    [3, :green, :diamond, :striped] => "Frame 21.png",
    [3, :green, :diamond, :open] => "Frame 23.png",
    [3, :green, :squiggle, :solid] => "Frame 68.png",
    [3, :green, :squiggle, :striped] => "Frame 62.png",
    [3, :green, :squiggle, :open] => "Frame 68.png",

    # Purple
    [3, :purple, :oval, :solid] => "Frame 45.png",
    [3, :purple, :oval, :striped] => "Frame 44.png",
    [3, :purple, :oval, :open] => "Frame 50.png",
    [3, :purple, :diamond, :solid] => "Frame 8.png",
    [3, :purple, :diamond, :striped] => "Frame 1.png",
    [3, :purple, :diamond, :open] => "Frame 5.png",
    [3, :purple, :squiggle, :solid] => "Frame 81.png",
    [3, :purple, :squiggle, :striped] => "Frame 80.png",
    [3, :purple, :squiggle, :open] => "Frame 86.png"
  }
end
