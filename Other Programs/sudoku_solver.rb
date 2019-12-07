# This program is a Sudoku puzzle solver. It uses the backtracking method described in the following
# Wikipedia post: https://en.wikipedia.org/wiki/Sudoku_solving_algorithms#Backtracking
# This is pretty much the same thing as a brute force search solution for a Sudoku puzzle.
# Author: Carson Smith, written for CS354 LW1 in Fall 2019

# This method will take in a string of characters and turn it into a two dimensional 
# array of numbers to act as the Sudoku puzzle board.
# input string should be 81 characters total, split into 9 rows by 9 newline characters.
# Non-numeric input characters (a-z etc...) will be considered as a 0 (blank space)
def parse_puzzle(input_string)
    # board = [][] # Make a blank starting array.
    puzzle = validate_input(input_string)
    if puzzle != false
        board = Array.new(9) { Array.new } # Declaration to make a 2D array with 9 subarrays in the outer array.
        count = 0                          # To keep track of the row count.
        for line in puzzle                 # For each line of the puzzle input
            for x in 0...line.length do  # Taking the values in the lines and putting them in the required row array.
                if line[x] == " "        # Simple parsing for an alternative input type.
                    line[x] = "0"
                end
                board[count].push(line[x].to_i)    # Splitting said values with quotation marks.
            end
            count = count + 1 # Incrementing count to go to the next row.
        end
        return board
    else
        return false
    end
end

# This method will make a list (array) of all the unsolved positions that are remaining on the input board.
# An unsolved position will take the format of a row and a column in an array within the return array of the method.
#
# Example: unsolved_positions = [[1,2], [2,6], etc...]
def get_unsolved_positions(board)
    unsolved_positions = []
    for row in 0...9 do # Getting the rows
        for col in 0...9 # Getting the columns
            if board[row][col] == " " || board[row][col] == "0" || board[row][col] == 0
                unsolved_positions.push([row, col])
            end
        end
    end
    return unsolved_positions
end

# Ensures that a location is valid for a number in all 3 ways, row, column, and block.
def validate_position(board, position, number)
    position_row = position[0]
    position_col = position[1]
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

# Validates the input, ensuring that the input to the program is valid.
def validate_input(input_string)
    puzzle = input_string.split(/\n/) # Using a regex to parse the input by the newline character.
    count = 0
    flag = true
    if puzzle.length != 9
        puts "Input String ERROR: The input string is not formatted correctly!"
        return false
    end
    for line in puzzle do
        if line.length != 9
            puts "Input String ERROR: The input string is not formatted correctly!"
            if line.length > 9
                puts "Line ##{count} has too many characters!"
            else
                puts "Line ##{count} doesn't have enough characters!"
            end
            puts "Expected: 9"
            puts "Actual:  #{line.length}"
            flag = false
        end
        count += 1
    end
    if flag == false 
        return false
    end
    return puzzle
end

# Takes a board and a list of unsolved positions and solves the Sudoku Puzzle.
def solve(board)
    unsolved_positions = get_unsolved_positions(board)

    # This is a simple check to ensure that the initial board isn't invalid from the beginning, causing solve() to run infinitely.
    for row in 0...9 do
        for col in 0...9 do
            number = board[row][col]
            if number != 0
                board[row][col] = 0           # Needed for the way validate_position is implemented.
                if validate_position(board, [row, col], number) == false
                    board[row][col] = number  # Needed for the way validate_position is implemented.
                    puts "Invalid initial input on row ##{row} and column ##{col}!"
                    return false
                end
                board[row][col] = number      # Needed for the way validate_position is implemented.
            end
        end
    end

    # unsolved_positions will be unchanged throughout the execution of solve(). 

    pos_count = 0 # A count variable for going over the unsolved positions.

    while pos_count < unsolved_positions.length
        unsolved_row = unsolved_positions[pos_count][0]               # Getting the col to check
        unsolved_col = unsolved_positions[pos_count][1]               # Getting the row to check
        experimental_number = board[unsolved_row][unsolved_col] + 1   # Getting the number and setting it to 1 by default.
        found = false                                                 # A flag to keep track of whether or not we need to backtrack.
        # This while block will increment the experimental_number over and over until it's found a valid position, where it will be set.
        while experimental_number < 10 && found == false              # Trying all the numbers, as long as the number is a valid one.
            if validate_position(board, unsolved_positions[pos_count], experimental_number) # If it's a valid place to put the number...
                pos_count = pos_count + 1                             # Increment the position count.
                board[unsolved_row][unsolved_col] = experimental_number # Set the value on the board.
                found = true                                          # Trip the found flag.
            else                                                      # Otherwise...
                experimental_number = experimental_number + 1         # Increment the number we are brute forcing. 
            end
        end

        # This while block checks for the condition where the found boolean flag is never tripped via the above while loop.
        if found == false
            pos_count = pos_count - 1             # De-increment count so the focus of the outer while loop goes back to the last position.
            board[unsolved_row][unsolved_col] = 0 # Reset the value of the board space that was being brute-forced.
        end
    end
    
    # The board should be solved at this point in execution.
    return board
end

# Prints the board to the output in a more visually appealing way than a simple block of numbers.
# It essentially just builds a string and returns it. Nothing special.
def print_pretty_board(board_input)
    pretty_board = ""
    for row in 0...9 do
        pretty_board = pretty_board + "-------------------------------------\n|"
        for col in 0...9 do
            pretty_board = pretty_board + " #{board_input[row][col]} |"
        end
        pretty_board = pretty_board + "\n"
    end
    pretty_board = pretty_board + "-------------------------------------\n"
    puts pretty_board
end

# The driver for the program.
def driver()
    puts "Welcome to Sudoku Puzzle Solver. Please choose an option from the list below:\n(I)nput a new puzzle.\nor\n(S)ee it in action with a default example.\n"
    selected_choice = gets.downcase
    
    # Ensures the user gives a proper selection.
    while selected_choice[0] != "i" && selected_choice[0] != "s"
        puts "Incorrect input! Please choose from the following:\n(I)nput a new puzzle.\nor\n(S)ee it in action with a default example.\n"
        selected_choice = gets.downcase
    end 

    # Handling the user's selection
    if selected_choice[0] == "i"
        puts "Please input the Sudoku puzzle you want to solve:"
        puts "Enter each row of numbers for the puzzle, starting from the top, hitting enter after each row of input."
        puzzle_string = ""
        for x in 0...9 do         # Concatonating the input from in.
            input = gets
            puzzle_string += input
        end
        board = parse_puzzle(puzzle_string)
    else selected_choice[0] == "s" # Sets the board to a default random thing I made.
        board = parse_puzzle("123456789\n000000000\n000000000\n004000000\n000000900\n000000070\n000800000\n000000000\n000000008\n")
    end
    if board != false # false is returned from parse_puzzle() when there is a problem with formatting. Error messages are actually printed elsewhere.
        puts "This is the starting board:\n"
        print_pretty_board(board) # Print the starting board.

        board = solve(board) # Solve the puzzle.

        if board == false # False is returned from solve() only under the condition when the board has an invalid position at the time of input.
            puts "ERROR: Board has an invalid position at the time of input. The board has no solution."
        else              # Otherwise we just print the solution to the user.
            puts "\nThis is the solution:\n"
            print_pretty_board(board)
        end
    end
end

driver()