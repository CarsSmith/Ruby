# Author: Devan Craig
# Description: Uses a user input to decide which calculator to use. 
# Then will take in the input of two numbers to do basic calculation 
# based on which operator is selected. 

class Calculator
    #Global Variables 
    $c = nil # Final Answer
    $a = nil # First Number
    $b = nil # Second Number
    $op = nil # Operator
  
   # Calls the Methods based on which calculator then places the result in a out file test.txt #
   def main()
    puts "Which Calculator do you want [r]egular or [b]inary"
    calc = gets.chomp
       if calc == 'r'
        regInput()
        regCalculate($a.to_i,$op,$b.to_i)
        writeToFile()
       elsif calc == 'b'
        binInput()
        binCalculate($a,$op,$b)
        writeToFile()
       else
        puts "Wrong Input"
       end
    end
    
    # Opens the file twice, once to truncate and a second time to put the answer in the file #
    def writeToFile()
      File.open("test.txt", 'w') { |file| file.truncate(0) } # Truncates File
      File.open("test.txt", 'w') { |file| file.write("Answer: #{$c}") } # Places the answer in the file
    end

    # User input for the stardard calculator #
    def regInput()
       puts "Enter The First Number"
       $a = gets.chomp
       puts "Enter Operator [+]add, [-]subtract, [*]multiply, [/]divide, [**]exponet"
       $op = gets.chomp
       puts "Enter The Second Number"
       $b = gets.chomp
    end

   # User input for the binary calculator #
    def binInput()
       puts "Enter The First Binary Number"
       $a = gets.chomp
       puts "Enter Operator [+]add, [-]subtract, [*]multiply, [/]divide, [**]exponet"
       $op = gets.chomp
       puts "Enter The Second Binary Number"
       $b = gets.chomp
    end
    
    # Creates all the work to calculate a binary equation #
    def binCalculate(a,op,b)
       ans = 0
       ans1 = 0
       a = $a.reverse
       b = $b.reverse
 
       i = 0
       # while loop block for the first binary string #
       while i <= $a.size
          if a[i] == '1'
             ans += 2**i 
          end
          i += 1
       end
       j = 0
       # while loop block for the second binary string #
       while j < $b.size
          if b[j] == '1'
             ans1 += 2**j
          end
          j += 1
       end
       
       # if, else if, else block for each operation #
       if op == "+"
        $c = ans.to_i + ans1.to_i
       elsif op == "-"
        $c = ans.to_i - ans1.to_i
       elsif op == "/"
        $c = ans.to_i / ans1.to_i
       elsif op == "*"
        $c = ans.to_i * ans1.to_i
       elsif op == "**"
        $c = ans.to_i ** ans1.to_i
       else
        $c = "Wrong Operator"
       end
    end
     
    # Creates all the work to calculate a regular equation #
    def regCalculate(a,op,b)
       # if, else if, else block for each operation #
       if op == "+"
          $c = a.to_i + b.to_i
       elsif op == "-"
          $c = a.to_i - b.to_i
       elsif op == "/"
          $c = a.to_i / b.to_i
       elsif op == "*"
          $c = a.to_i * b.to_i
       elsif op == "**"
          $c = a.to_i ** b.to_i
       else
          $c = "Wrong Operator"
       end
    end
 
 end
 
 run = Calculator. new
 run.main
 