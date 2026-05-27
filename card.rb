class Card
    SHAPE = [:trigle, :square, :diamond]
    COLOR = [:red, :green, :yellow]
    NUMBER = [1, 2, 3]
    PATTERN = [:solid, :striped, :open]

    attr_reader :shape, :color, :number, :pattern


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

    def to_s
        "#{number} #{color} #{pattern} #{shape}"
    end
end