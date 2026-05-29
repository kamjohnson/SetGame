# File created 5/27/26 by Michael Cintron

class SetValidator
    SHAPES = [:squiggle, :oval, :diamond]

    # Created 5/27/26 by Michael Cintron
    # Method that checks if the given shapes would violate a set.
    # 
    # @param [symbol] shape0, shape1, shape2 The three given shapes
    # 
    # return [true] if all the shapes are the same OR if they are all different
    def validateShape shape0, shape1, shape2
        numUniq = [shape0, shape1, shape2].uniq.length
        return true if numUniq == 1 || numUniq == 3            
    end
end
