=begin
File created 5/27/26 by Michael Cintron
File edited 5/28/26 by Michael Cintron - Verifying entire card, not just shape
File edited 5/31/26 by Michael Cintron - made validateProperty? more terse
File Edited 6/2/26 by Michael Cintron - revised comments and made code more terse
=end

class SetValidator
    SHAPES = [:squiggle, :oval, :diamond]

    # Created 5/27/26 by Michael Cintron
    # Edited 5/28/26 by Michael Cintron - Made more terse and renamed to be for all properties
    # Edited 5/31/26 by Michael Cintron - Made more terse
    # Edited 6/2/26 by Michael Cintron - Made into single line
    # Checks if the given properties would violate a set.
    # 
    # @param [symbol] prop0, prop1, prop2 The three given shapes
    # 
    # return [true] if all the properties are the same OR if they are all different
    def validateProperty? (prop0, prop1, prop2) [prop0, prop1, prop2].uniq.length != 2 end

    # Created 5/28/26 by Michael Cintron
    # Edited 6/2/26 by Michael Cintron - revised comments to be clearer
    # Checks if the three given card strings make a valid set.
    # 
    # @param [Card] card0, card1, card2 The three given cards.
    # 
    # return [true] if all three cards form a valid set.
    def validateCards? card0, card1, card2
        # split each card into their four property components
        number0, color0, pattern0, shape0 = card0.to_s.split
        number1, color1, pattern1, shape1 = card1.to_s.split
        number2, color2, pattern2, shape2 = card2.to_s.split
        
        # create a 2D array where each row contains the same card property from each card
        propertyArray = [ 
            [shape0, shape1, shape2],
            [color0, color1, color2],
            [number0, number1, number2],
            [pattern0, pattern1, pattern2]
        ]
        
        # check each property to make sure they do not violate a set
        propertyArray.all? { |prop0, prop1, prop2| validateProperty? prop0, prop1, prop2 }
    end
end
