# Project-2-3WAG-SWAG-
CSE3901 - Summer 2026

# Execution instructions

# Managers
## Overall Project Manager: Kameron Johnson
## Meeting Manger: Michael Cintron 

# Meeting Reports

## 5/21/26 Notes
(Hongle, Michael, Kameron, Joon)
### Goal: Figure out what we need to do for the first project 1 submission. 
- Putting off real meeting to weekend so we can look over project in more depth and let Denis participate 
- Start with base game single player, no pretty UI, just checking if valid set checking 
- Potential classes: base game, player, card, timer, leaderboard
- Think about use cases for next meeting
- Looking into what the preliminary class diagram 
- Create a list of various Ruby methods from the slides
- Documentation conventions
- Flesh out testing (Rspec)
- Determine what we want to get done for our first sprint and how long it will go for
- Kameron will reach out to Denis to see if his schedule would line up with a Saturday meeting
- Team members bring “goals” to next meeting 

## 5/23/26 Notes
(Hongle, Michael, Kameron, Joon)
### Meeting goals:
- Michael:
    - Finish developing the class diagrams
    - Finish content for the Sunday submission
        - Figure out use cases
- Kameron: 
    - Get good understanding of how to document our code
        - Convention
    - Confirming testing library
        -Rspec? 
- Joon:
    - Setting up sprint plans
        - Which parts of code will be worked on
    - Developing project plans 
        - Which core functions will be implemented 
        - Additional functions 
- Hongle: 
    - Confirm the scope of the code to be submitted next Thursday.
    - Understand the whole picture of what we are doing 

The meeting notes were essentially our 5/24/26 submission;
- Spent time figuring out our base use cases
- Went back and forth on what classes we needed
    - Created base class diagram
- Laid out first sprint 
    - end on 5/26/26
    - 

# Use Cases
-(Kameron) Game mechanics Ending:
    - The program checks to see if there are cards left, or if any additional sets are possible.
    - If not, the program ends the game, checks the score of the player, or compares the scores of multiple players, and then announces a winner. 
    - If there is a tie between players, the game will indicate that.
    - If there is a leaderboard, the players' score will be entered and sorted into the leaderboard.
    - The results are shown, and then player1 will have the option to play again, quit to the menu, or choose a different game mode.
- (Joon) Select game mode: A user can select one of three game modes (a tutorial mode, a singleplayer mode, and a multiplayer mode)
    - The user starts game.
    - The game displays three game modes (a tutorial mode, a singleplayer mode, a multiplayer mode)
    - The user selects one of the game modes. 
    - If a tutorial mode is chosen, a practice version of the game starts. This mode has no time limit and no point deductions.  
    - If a singleplayer mode is chosen, a singleplayer version of the game starts. This mode has a time limit and point deduction is the chosen set is wrong.
    - If a multiplayer mode is chosen, a multiplayer version of the game starts. This mode allows users to compete against each other using the penalty system. 
- (Michael): User flow: After a game is finished, a user may select to go back to the gamemode selection, play the same gamemode again, or quit out.
    - During the game, the user may provide an input to pause the game and be provided the gamemode selection, restart game, or quit options.
    - Ctrl+D to escape the game (get nil from user) 
- (Hongle): Cards verify and view: Player can select 3 cards(by using mouse or keyboard) from the cards(12) that draw from the 81 cards.
    - the game should verify that the selected cards are a set.
    - If it is a set. Remove the selected cards and refill the empty cards with news cards draw from the 81 cards
    - If the selected cards are not a set remain the table with same cards, and the player try again
    - If none of the cards on the table can form a set, enter empty selection, and the game should verify that, if it is true draw new cards(12) from the 81, old cards goes to the waste. Ex: 12 cards are not valid for any set, recards will choose from (81-12)= 69
- (Denis): handling concurrent card selection amongst players  
    - For the case where players both select a valid set at the same time, the game will properly handle two sets or the same sets being claimed by placing a lock on the specific cards to prevent both sides selecting them at once 
    - If a second player attempts to select any of the locked cards, the system will notify the use that the cards are highlighted and are currently selected by another player 
    - After this point, the locked cards will be checked to see if form valid set 
    -If the set is valid, the cards are removed like normal and the lock is removed and the board is updated for all users. If the set is invalid, the lock is still removed and the cards can be reselected by any player 

# Sprints
## Sprint #1 (End 5/26/26)
- Basic Gameplay loop (Kameron)
    - Start game -> mode 
- Skeleton of Classes / file structure (All) 
- Rspec setup - individual
- Basic Card Class functionality  
    - Define card attributes (color, shape, number, shading)（Hongle
    - to_s (Michael) 
- BOARD (Denis)
    - Define class structure for Board which has visibleCards and methods of displayBoard and replaceCards
    - Form logic for removing valid sets, refreshing the board with new cards from deck, and case handling for when no sets are on table (drawing 3 cards)
    - Make a lock to prevent players from selecting a set at the same moment and removing the lock when the sets are removed or if invalid after verification
- Basic Player Class functionality
    - Define player attributes (username, user id, score) (Joon) 
- Set up README (Michael) 

... continue ...
