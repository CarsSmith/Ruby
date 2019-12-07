#This class fills in the student information from the user input 
class PersonInput
  
  #Asks the user to enter their information
  #There is no Scanner class in Ruby so the only way to get
  #user input is to use the gets method.
  puts "Enter your name: "
  name = gets.chomp()
  
  puts "Enter your Class Standing: "
  classStanding = gets.chomp()
  
  puts "Enter Student ID: "
  studentID = gets.chomp()
  
  puts "Enter GPA: "
  gpa = gets.chomp()
  
  puts "Enter all of your classes the you are currently enrolled: "
  classes = gets
  
  puts("\n")
  
  #prints out the user input 
  
  puts ("Student Name: " + name)
  puts ("Class Standing: " +classStanding)  #puts is the equivalent of System.out.println
  puts ("Student ID: " + studentID)         
  puts ("GPA: " + gpa)
  puts ("Classes: " + classes)
  
end