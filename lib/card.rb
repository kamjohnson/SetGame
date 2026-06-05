=begin create 5/27 by Hongle Chen
Edited on 5/27/27 by Michael Cintron - Moved to lib folder
Initialize a card with shape, color, count, and pattern
validate the input parameters to ensure they are valid
provide a string representation of the card for easy display
Edited on 6/5/2027 by Kameron Johnson - added :image path for 
  cards to be linked to their gui representation
=end 
class Card
    # updated shape and color 5/27 Hongle Chen
    # Modified 6/5 by Kameron Johnson
    SHAPE = [:squiggle, :oval, :diamond]
    COLOR = [:red, :green, :purple]
    NUMBER = [1, 2, 3]
    PATTERN = [:solid, :striped, :open]

    attr_reader :shape, :color, :number, :pattern, :image_path

    # Created 5/27  By Hongle Chen
    # Modified 6/5 by Kameron Johnson - added @image_path for gui representation.
    def initialize(shape, color, number, pattern)

        raise ArgumentError, "Invalid shape" unless SHAPE.include?(shape)
        raise ArgumentError, "Invalid color" unless COLOR.include?(color)
        raise ArgumentError, "Invalid number" unless NUMBER.include?(number)
        raise ArgumentError, "Invalid pattern" unless PATTERN.include?(pattern)
        @shape = shape
        @color = color
        @number = number
        @pattern = pattern
        @image_path = nil;
    end
    # Created 5/27  By Hongle Chen
    # into one line terse code 6/2/26 Hongle Chen
    def to_s = "#{number} #{color} #{pattern} #{shape}"

  # Created 6/5 by Kameron Johnson
  # Setter method to assign card to image
  # 
  # @param file_name [String] the name of the image file
  # @return [void] sets the instance variable @image_path
  def assign_image(file_name) = @image_path = "assets/#{file_name}"

end
