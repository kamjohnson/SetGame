# File created 5/25/2026 by Joon Yoo

class Player
    attr_reader :playerID, :playerName, :score

    # Created 5/25/2026 by Joon Yoo
    # Sets the player's ID, name, and starting score when a new player is created.
    def initialize (playerID = 0, playerName = "Anonymous", score = 0)
        @playerID = playerID
        @playerName = playerName
        @score = score
    end

    # Created 5/25/2026 by Joon Yoo
    # Adds the given amount to the player's score.
    def addPoint(amount)
        @score += amount
    end

    # Created 5/25/2026 by Joon Yoo
    # Deducts the given amount from the player's score.
    def deductPoint(amount)
        @score -= amount
    end
end
