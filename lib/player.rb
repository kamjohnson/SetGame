# File created 5/25/2026 by Joon Yoo
# Edited 5/28/2026 by Joon Yoo - Refactored using terse code
# Edited 6/1/2026 by Joon Yoo - Added logic to prevent points from being deducted
#   if the score is already 0.
# Edited 6/2/2026 by Joon Yoo - Refactored deductPoint method using a ternary operator.

class Player
    attr_reader :playerID, :playerName, :score

    # Created 5/25/2026 by Joon Yoo
    # Sets the player's ID, name, and starting score when a new player is created.
    def initialize playerID = 0, playerName = "Anonymous", score = 0
        @playerID, @playerName, @score = playerID, playerName, score
    end

    # Created 5/25/2026 by Joon Yoo
    # Adds the given amount to the player's score.
    def addPoint(amount) @score += amount end

    # Created 5/25/2026 by Joon Yoo
    # Edited 6/1/2026 by Joon Yoo - Added logic to prevent points from being deducted
    #   if the score is already 0.
    # Edited 6/2/2026 by Joon Yoo - Refactored using a ternary operator.
    # Deducts the given amount from the player's score. If the score is already 0,
    #   display message.
    def deductPoint amount
        @score == 0 ? puts("Score is already 0. No point was deducted.") : @score -= amount
    end
end
