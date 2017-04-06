### Win combinations saved in a multidimensional
### array 
################################################
WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], # VERTICAL WINS
  [0, 3, 6], [1, 4, 7], [2, 5, 8], # HORIZONTAL WINS
  [0, 4, 8], [2, 4, 6]                 # DIAGONAL WINS
]
###############################################

# Display_board function displays board in console

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
###############################################

# input_to_index function takes user_input and
# converts it into an integer minus one to get
# a correct index for the board array

def input_to_index(user_input)
  index = user_input.to_i - 1
end
###############################################

# The move function takes 3 arguments: The board,
# the index of the board and which player is currently
# playing "X" or "O"

def move(board, index, player)
  board[index] = player
end
###############################################

# position_taken? returns true if the location
# or index of the board array is not blank

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
##############################################

# valid_move returns true if the index given is
# between 0-8 and the position is not taken

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
##############################################

# the turn function prompts the user to input a
# number, gets it and converts it to a proper
# index. Logic: if valid move is true call
# move function and display board else call turn
# again recursively.

def turn(board)
  puts "Please choose a number between 1 and 9"
  input = gets.strip
  user_move = input_to_index(input)

  if valid_move?(board, user_move)
    move(board, user_move, current_player(board))
     display_board(board)
  else
    turn(board)
  end
end
 ###############################################

# Turn counts how many X's or O's on the board
# and returns a count

def turn_count(board)
  turn = 0
  board.each do |xo|
  	if xo == "X" || xo == "O"
      turn += 1
    end
  end
  turn
end
################################################

# Uses the turn_count method to find the current
# player and returns it.

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end
###############################################

# The won? method returns the winning combination
# from WIN_COMBINATIONS

def won?(board)
  WIN_COMBINATIONS.each do |win|
    win_index_1 = win[0]
    win_index_2 = win[1]
    win_index_3 = win[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win
      else
        false
      end
  end
  false
end
##############################################

# Full? checks to is if the entire board
# is taken by X or O

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end
###############################################

# draw? method uses both won? and full? to find out
# if the board is full and no player has won the
# game.

def draw?(board)
   !won?(board) && full?(board)
 end
##############################################

def over?(board)
   won?(board) || full?(board) || draw?(board)
 end
##########################################
 
 def winner(board)
    if won?(board)
      board[won?(board)[0]]
    end
  end
#############################################

def play(board)
  until over?(board)
    turn(board)
  end
  if  won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

