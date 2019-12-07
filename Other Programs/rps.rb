# Author: Andrew Lee
# Description: Plays a game of rock, paper, scissors using
# user input. First asks the number of rounds you want to play,
# and then cycles through each round until the user or the bot
# has won a majority of the rounds.
class RockPaperScissors

  # Runs when RockPaperScissors.new is called
  def initialize
    # Class Variables 
    @gamesWon = 0
    @gamesLost = 0
    @roundsWon = 0
    @roundsLost = 0
    @roundsLeft = 0
    @totalRounds = 0
    @playerChoice = nil
    @botChoice = nil
  end

  # Initializes a new game
  def newGame
    @roundsWon = 0
    @roundsLost = 0
    @totalRounds = 0
    @roundsLeft = 0
    puts "--Rock, Paper, Scissors--"
    while @totalRounds == 0
      print "Best out of: "
      input = Integer(gets) rescue 0 # If user doesn't enter an integer assign input as 0
      if input > 0 and input % 2 != 0 # If number chosen is an odd natural number
	@totalRounds = input
        @roundsLeft = input
      else
        puts "Please choose an odd positive number!"
      end
    end
    newRound()
  end
  
  # Starts a new round
  def newRound
    roundsNeededToWin = totalRounds/2
    @playerChoice = nil

    # If all rounds are complete or one of the players
    # have won a majority of the rounds, end the game
    if @roundsLeft == 0 or @roundsWon > roundsNeededToWin or @roundsLost > roundsNeededToWin
      finishGame()
    else
      while @playerChoice.nil?
        print "Rock, paper, scissors, shoot: "
        input = gets.chomp
        parseChoice(input.downcase)
      end

      # Choose a random option for the bot
      @botChoice = ["rock", "paper", "scissors"].sample
      puts "Bot chose #{@botChoice}."

      determineWinner()
      newRound()
    end
  end

  # Takes the user input and parses their option of
  # rock, paper, or scissors
  def parseChoice(input)
    case input
    when "r", "rock"
      @playerChoice = "rock"
    when "p", "paper"
      @playerChoice = "paper"
    when "s", "scissors"
      @playerChoice = "scissors"
    else
      puts "Please enter 'rock', 'paper', 'scissors', or their abbreviated versions (r,p,s)"
    end
  end

  # Determines the winner of each round, and increments
  # the win count or loss count respectively
  def determineWinner
    if @botChoice == @playerChoice
      puts "It's a tie! Redo round:"
    elsif (@playerChoice == "paper" and @botChoice == "rock") or \
          (@playerChoice == "scissors" and @botChoice == "paper") or \
          (@playerChoice == "rock" and @botChoice == "scissors")
      @roundsWon += 1
      @roundsLeft -= 1
      puts "You won this round! Rounds Won: #{@roundsWon}. Rounds Lost: #{@roundsLost}"
    else
      @roundsLost += 1
      @roundsLeft -= 1
      puts "You lost this round... Rounds Won: #{@roundsWon}. Rounds Lost: #{@roundsLost}"
    end
  end

  # Ends the game and tells you if you won or lost
  def finishGame
    if @roundsWon > @roundsLost
      puts "You won the game!"
      @gamesWon += 1
    else
      puts "You lost the game :("
      @gamesLost += 1
    end
    puts "Games Won: #{@gamesWon}. Ganes Lost: #{@gamesLost}"
    requestNewGame()
  end

  # Asks if you wants to start a new game.
  # Starts a new game if you respond 'yes', exits
  # the program if you respond 'no'.
  def requestNewGame
    print "Do you want to play again? (y/n): "
    wantsNewGame = nil
    while wantsNewGame.nil?
      input = gets.chomp.downcase
      case input
      when "y", "yes"
        wantsNewGame = true
      when "n", "no"
        wantsNewGame = false
        puts "Thanks for playing!"
      else
        puts "Please enter 'yes' or 'no' or their abbreviations (y,n)"
      end
    end
    if wantsNewGame
      newGame()
    end
  end

end

rps = RockPaperScissors.new
rps.newGame
