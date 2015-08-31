# Chess
This is a command line version of chess written in Ruby.

To run the game Ruby must be installed. Once you have installed Ruby, you can download this repository, open your terminal, and run bundle install in the command line. Once you have this set up, you can run the game with the command:

$ ruby game.rb

You can select your game mode.

![modeselect]

 and then play!

 ![chess]

To select a piece, move the cursor using the keys "wasd" and hit the enter key when the cursor is on the piece you want to select. Move to the place you wish to move the piece and hit the enter key again. To quit the game, hit "q".

When you select a piece you may want to move, the possible moves for that piece are shown in blue. The game makes sure players don't move into check but it will notify a player when they are in check.

## Implementation

#Custom Deep Dup

In order to test the valid moves for each piece and to see whether a player is in check, the board has a custom deep dup method that duplicates the board AND all of the pieces on the board.

#Computer Player

The computer player selects its move by checking to see if any of their pieces moves puts the other player into checkmate. If so, it makes that move. If not it is able to check if any of their pieces moves puts the other player into check. If so, it makes that move. If not it randomly selects a move.

#Keeping Code DRY

The code is kept dry through the use of modules and class inheritance. Two modules for piece movement, Stepable and Slideable, are included in the different piece classes. The piece classes all inherit from a Piece class that contains common methods for the different piece types.


[chess]: ./images/chess.gif
[modeselect]: ./images/mode.png
