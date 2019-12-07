# This Program uses a sequence of numbers to create a sum
class Sum
   # Global Variables
   $sum = 0
  def main()
      seq = [5,6,1,8,3,7] # array of numbers
      sum(seq) # Calls the sum method
      puts $sum # prints sum
   end
   # Takes in an array of numbers to then be added to sum
   def sum(seq)
      seq.each do |seq| # loop through everything in seq
      $sum+=seq #Add each number to sum
      end
   end
end
run = Sum. new
run.main