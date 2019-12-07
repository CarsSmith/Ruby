require 'ruby2d'

set title: "Sudoku"
set background: '#black'

WINDOW_SIZE = 650
set width: 800
set height: 645

class SudokuSquare
  def initialize(x, y, value, editable, color, size)
    @x = x
    @y = y  
    @value = value
    @editable = editable
    @tileColor = color
    @SIZE = size
    @square
    @textbox
    drawInitial
  end

  def drawInitial
    @square = Square.new(x: @x * @SIZE, y: @y * @SIZE, size: (@SIZE - @SIZE.div(18)), color: @tileColor)
    updateText
  end

  def getValue
    return @value
  end

  def changeValue(newValue)
    if(newValue.is_a?(Integer))
      newValue = newValue.to_s
    end

    if(@editable)
      if(('0'..'9').include? newValue.chomp)
        @value = newValue.chomp.to_i
        updateText
      end
    end
  end



  def isEditable
    return @editable
  end

  def select 
    @square.remove
    @square = Square.new(x: @x * @SIZE, y: @y * @SIZE, size: (@SIZE - @SIZE.div(18)), color: 'yellow')
  end

  def deselect
    @square.remove
    @square = Square.new(x: @x * @SIZE, y: @y * @SIZE, size: (@SIZE - @SIZE.div(18)), color: @tileColor)
  end

  def disable
    @editable = false
    updateText
  end

  def updateText
    if @textbox
      @textbox.remove
    end

    if @value != 0
      textColor = @editable ? '#8c51b0' : 'black'
      @textbox = Text.new(@value, x: @x * @SIZE + (@SIZE/4.2), y: @y * @SIZE, size: @SIZE / 1.2, color: textColor, z: 10)
    end
  end

  def remove
    @square.remove
    if(@textbox)
      @textbox.remove
    end
  end
end

class SudokuBoard

  def initialize(board, size, color1, color2)
    @board = makeBoard(board, size, color1, color2)
    @selectedX = 0
    @selectedY = 0
    selectSquare(@selectedX,@selectedY)
  end

  def makeBoard(board, size, color1, color2)
    newBoard = Array.new(9) {Array.new(9)}
    for i in 0..8 do
      for j in 0..8 do
        #for creating 3x3 pattern in grid
        color = color1
        if (i.div(3) == 1 && j.div(3) != 1) || (i.div(3) != 1 && j.div(3) == 1)
          color = color2
        end

        editable = true
        if(board[i][j] != 0)
          editable = false
        end

        newBoard[i][j] = SudokuSquare.new(i, j, board[i][j], editable, color, size/9)
      end
    end
    return newBoard
  end

  #gets board with current digits
  def getCurrentBoard
    currentBoard = Array.new(9) {Array.new(9)}
    for i in 0..8 do
      for j in 0..8 do
        currentBoard[i][j] = @board[i][j].getValue
      end
    end
    return currentBoard
  end

  #gets base board without user input digits
  def getBaseBoard
    baseBoard = Array.new(9) {Array.new(9)}
    for i in 0..8 do
      for j in 0..8 do
        if(@board[i][j].isEditable)
          baseBoard[i][j] = 0
        else
          baseBoard[i][j] = @board[i][j].getValue
        end
      end
    end
    return baseBoard
  end

  def getSquareValue(x,y)
    return @board[x][y].getValue
  end

  def changeSquareValue(x,y,value)
    @board[x][y].changeValue(value)
  end

  def isSquareEditable(x,y,value)
    return @board[x][y].isEditable
  end

  def disableSquare(x,y)
    @board[x][y].disable
  end

  def selectSquare(x,y)
    @board[@selectedX][@selectedY].deselect
    @board[x][y].select
    @selectedX = x
    @selectedY = y
  end

  def replaceSolvedBoard(board)
    for i in 0..8 do
      for j in 0..8 do
        @board[i][j].changeValue(board[i][j])
        @board[i][j].disable
      end
    end
  end

  def removeBoard
    for i in 0..8 do
      for j in 0..8 do
        @board[i][j].remove
      end
    end
  end
end

class SudokuInput
  def makeButtons
    @newGameButton = Image.new(
      'newgame.png',
      x: 665, y: 25,
      width: 115, height: 60,
    )

    @solutionButton = Image.new(
      'Solution.png',
      x: 665, y: 125,
      width: 115, height: 60,
    )

    @hint = Image.new(
      'hint.png',
      x: 665, y: 225,
      width: 115, height: 60,
    )

    @check = Image.new(
      'check.png',
      x: 665, y: 325,
      width: 115, height: 60,
    )

  end

  def sureButton
    @sure = Image.new(
      'sure.png',
      x: 665, y: 425,
      width: 115, height: 60,
    )
    return @sure
  end

  def yesButton
    @yes = Image.new(
      'yes.png',
      x: 665, y: 495,
      width: 55, height: 30,
    )
    return @yes
  end

  def noButton
    @no = Image.new(
      'no.png',
      x: 725, y: 495,
      width: 55, height: 30,
    )
    return @no
  end

  def winImage
    @win = Image.new(
      'win.png',
      x: 665, y: 425,
      width: 115, height: 60,
    )
    return @win
  end

  def NewGame
    print "new game"
  end

  def Hint
    print "Hint"
  end

  def Check
    print "check"
  end
end

class Sudoku_Solver_Generator
  def initialize(s_number)
    @s_number = s_number
  end

  def get_unsolved_positions(board)
    us_positions = []
    for row in 0...9 do # Getting the rows
      for col in 0...9 # Getting the columns
        if board[row][col] == "0" || board[row][col] == 0
          us_positions.push([row, col])
        end
      end
    end
    return us_positions
  end

  # Ensures that a location is valid for a number in all 3 ways, row, column, and block.
  def validate_position(board, row, col, number)
    position_row = row
    position_col = col
    # Checks the row to ensure there's no duplicate while also checking the column to ensure there's no duplicate.
    for val in 0...9 do
      if board[val][position_col] == number || board[position_row][val] == number
        return false
      end
    end

    # Defining the boundaries of the block that the given position falls into...
    block_row_min = position_row / 3 * 3      # Abusing integer division to get the lower bound for the rows.
    block_row_max = block_row_min + 3         # Max is just 3 higher than that.
    block_col_min = position_col / 3 * 3      # Abusing integer division to get the lower bound for the columns.
    block_col_max = block_col_min + 3         # Max is just 3 higher than that.

    # Checks that the given position is valid, given the dimensions calculated above...
    for row in block_row_min...block_row_max do
      for col in block_col_min...block_col_max do # Simple double for-loop with an if statement.
        if board[row][col] == number
          return false
        end
      end
    end
    return true
  end

  def get_new_board
    new_board = get_blank_board
    temp_solution = solve(new_board)
    if temp_solution == false
      return false
    else 
      game_board = remove_values(temp_solution)
      return game_board
    end
  end

  def remove_values(board)
    positions = generate_random_positions()

    for pos in positions do 
      board[pos[0]][pos[1]] = 0
    end
    return board
  end

  def generate_random_positions()
    all_positions = []
    for row in 0...9 do
      for col in 0...9 do
        all_positions.push([row, col])
      end
    end
    shuffled_positions = all_positions.shuffle()
    random_position_array = shuffled_positions.drop(@s_number)
    return random_position_array
  end

  def solve(board)\

    # This is a simple check to ensure that the initial board isn't invalid from the beginning, causing solve() to run infinitely.
    for row in 0...9 do
      for col in 0...9 do
        number = board[row][col]
        if number != 0
          board[row][col] = 0           # Needed for the way validate_position is implemented.
          if validate_position(board, row, col, number) == false
            board[row][col] = number  # Needed for the way validate_position is implemented.
            return false
          end
        board[row][col] = number      # Needed for the way validate_position is implemented.
        end
      end
    end

    unsolved_positions = get_unsolved_positions(board)
    oops_count = 0
    # unsolved_positions will be unchanged throughout the execution of solve(). 
    posit_count = 0 # A count variable for going over the unsolved positions.
    while posit_count < unsolved_positions.length
      #p posit_count
      unsolved_row = unsolved_positions[posit_count][0]               # Getting the col to check
      unsolved_col = unsolved_positions[posit_count][1]               # Getting the row to check
      experimental_number = board[unsolved_row][unsolved_col] + 1   # Getting the number and setting it to 1 by default.
      found = false                                                 # A flag to keep track of whether or not we need to backtrack.
      # This while block will increment the experimental_number over and over until it's found a valid position, where it will be set.
      while experimental_number < 10 && found == false              # Trying all the numbers, as long as the number is a valid one.
        if validate_position(board, unsolved_row, unsolved_col, experimental_number) # If it's a valid place to put the number...
          posit_count = posit_count + 1                             # Increment the position count.
          board[unsolved_row][unsolved_col] = experimental_number # Set the value on the board.
          found = true                                          # Trip the found flag.
        else                                                      # Otherwise...
          experimental_number = experimental_number + 1         # Increment the number we are brute forcing. 
        end
      end

      # This while block checks for the condition where the found boolean flag is never tripped via the above while loop.
      if found == false
        oops_count = oops_count + 1
        posit_count = posit_count - 1             # De-increment count so the focus of the outer while loop goes back to the last position.
        board[unsolved_row][unsolved_col] = 0 # Reset the value of the board space that was being brute-forced.
      end

      if posit_count < 0
        return false
      end
      if oops_count > 200000
        return false
      end
    end
    return board
  end


  def get_blank_board
    new_board = [[0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0]]
    list = [1,2,3,4,5,6,7,8,9]
    list = list.shuffle
    new_board[0] = list
    return new_board
  end

end

# Creating Variables that will be used after starting the game #
@gen_sol = Sudoku_Solver_Generator.new(35)
new_board = @gen_sol.get_new_board()
@gameBoard = SudokuBoard.new(new_board, WINDOW_SIZE, 'white', 'gray')
@input = SudokuInput.new
@input.makeButtons

# Starting Index for the board movement #
currentX = 0
currentY = 0

# Used for the movement of keys #
on :key_up do |event2|
  if event2.key == 'left'
    if(currentX != 0)
      currentX = currentX - 1
    end
  elsif event2.key == 'right'
    if(currentX != 8)
      currentX = currentX + 1
    end
  elsif event2.key == 'up'
    if(currentY != 0)
      currentY = currentY - 1
    end
  elsif event2.key == 'down'
    if(currentY != 8)
      currentY = currentY + 1
    end
  end

  @gameBoard.selectSquare(currentX,currentY)
end

# Used for the user input in the sudoku board #
on :key_down do |event|
    puts event.key
    @gameBoard.changeSquareValue(currentX,currentY,event.key)
end

# Used for the mouse clicking on a button #
on :mouse_down do |event3|
  # x and y coordinates of the mouse button event
  x = event3.x
  y = event3.y
  # For New Game Button #
  if x.between?(665, 780) && y.between?(25, 85)
    #if @rWin.defined? == true
    #  @rWin.remove
    #end
    @gameBoard.removeBoard
    board = @gen_sol.get_new_board
    @gameBoard = SudokuBoard.new(board, WINDOW_SIZE, 'white', 'gray')
    currentX = 0
    currentY = 0

  # For Solution Button #
  elsif x.between?(665, 780) && y.between?(125, 185)
    @rSure = @input.sureButton
    @rYes = @input.yesButton
    @rNo = @input.noButton
  # For Hint Button #
  elsif x.between?(665, 780) && y.between?(225, 285)
    @input.Hint
  # For Check Button #
  elsif x.between?(665, 780) && y.between?(325, 385)
    currentBoard = @gameBoard.getCurrentBoard
    solvedBoard = @gen_sol.solve(currentBoard)
    if solvedBoard == false
      p 'Somethings wrong!'
    else
      @rWin = @input.winImage
    end
  end
end

on :mouse_down do |event3|
  def removeButton
    @rYes.remove
    @rNo.remove
    @rSure.remove
  end
  # x and y coordinates of the mouse button event
  x = event3.x
  y = event3.y
  if x.between?(665, 720) && y.between?(495, 525)
    solvedBoard = @gen_sol.solve(@gameBoard.getBaseBoard)
    @gameBoard.replaceSolvedBoard(solvedBoard)
    removeButton
  elsif x.between?(725, 780) && y.between?(495, 525)
    removeButton
  end
end

show