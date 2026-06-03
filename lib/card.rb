
# create 5/27 by Hongle Chen
# Edited on 5/27/27 by Michael Cintron - Moved to lib folder
# initialize a card with shape, color, count, and pattern
# validate the input parameters to ensure they are valid
# provide a string representation of the card for easy display
class Card
    # updated shape and color 5/27 Hongle Chen
    SHAPE = [:squiggle, :oval, :diamond]
    COLOR = [:red, :green, :purple]
    NUMBER = [1, 2, 3]
    PATTERN = [:solid, :striped, :open]

    attr_reader :shape, :color, :number, :pattern

    # Created 5/27  By Hongle Chen
    def initialize(shape, color, number, pattern)

        raise ArgumentError, "Invalid shape" unless SHAPE.include?(shape)
        raise ArgumentError, "Invalid color" unless COLOR.include?(color)
        raise ArgumentError, "Invalid number" unless NUMBER.include?(number)
        raise ArgumentError, "Invalid pattern" unless PATTERN.include?(pattern)
        @shape = shape
        @color = color
        @number = number
        @pattern = pattern
    end
    # Created 5/27  By Hongle Chen
    # into one line terse code 6/2/26 Hongle Chen
    def to_s = "#{number} #{color} #{pattern} #{shape}"

end
