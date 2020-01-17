class TicTacToe

  def initialize(board = nil) #given
    @board = Array.new(9, " ")
  end
  
  WIN_COMBINATIONS = [
    #Board layout
    # 0 | 1 | 2
    #-----------
    # 3 | 4 | 5
    #-----------
    # 6 | 7 | 8

    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row
    [0,3,6],  # Left col
    [1,4,7],  # Middle col
    [2,5,8],  # Right col
    [0,4,8],  # Diagnol 1
    [2,4,6]  # Diagnol 2
  ]
  
  #prints the current board representation based on the @board instance variable.
  def display_board 
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  #correctly translate that from the player's perspective to the array's
  def input_to_index(input)
    input.to_i - 1
  end
  
  #take in two arguments: the index in the @board array that the player chooses and the player's token, defaults to X
  def move(index, current_player = "X")
    @board[index] = current_player
  end  
  
  #evaluating the user's desired move against the Tic Tac Toe board and checking to see whether or not that position is already occupied. 
  def position_taken?(index)
    @board[index] != " "
  end
  
  #accepts a position to check and returns true if the move is valid and false or nil if not
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end  
  
  #logic of a single complete turn, see lad intrustion for details
  def turn    
    cp = current_player
    puts "#{cp}'s turn, please enter a number 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, cp)
    else
      turn
    end
    display_board
  end
  
  #returns the number of turns that have been played based on the @board variable.
  def turn_count
    turn = 0
    @board.each do |index|
      if index == "X" || index == "O"
        turn += 1
      end
    end
    return turn
  end
  
  #use the turn_count method to determine if it is "X"'s or "O"'s turn.
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  #return false/nil if there is no win combination present in the board and return the winning combination indexes as an array if there is a win using WIN_COMBINATIONS constant.
  def won?
    WIN_COMBINATIONS.each {|win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]

      position_1 = @board[index_0]
      position_2 = @board[index_1]
      position_3 = @board[index_2]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combo
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combo
      end
    }
    return false
  end
  
  #return true if every element in the board contains either an "X" or an "O".
  def full?
    @board.all?{|x| x == "X" || x == "O"}
  end
  
  #returns true if the board is full and has not been won, false if the board is won, and false if the board is neither won nor full.
  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end

  #returns true if the board has been won or is full (i.e., is a draw).
  def over?
    if won? || draw?
      return true
    else
      return false
    end
  end

  #return the token, "X" or "O", that has won the game.
  def winner
    index = []
    index = won?
    if index == false
      return nil
    else
      if @board[index[0]] == "X"
        return "X"
      else
        return "O"
      end
    end
  end
  
  #Begin the game! Main method of the Tic Tac Toe application and is responsible for the game loop.
  def play
    until over? == true
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end