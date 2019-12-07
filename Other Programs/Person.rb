#Person class creates and gets the person's first and last name
class Person
  #Constructor
  def initialize(first,last)
    @firstname = first
    @lastname = last
  end
  
  #Getter
  def getFirstName
    return @firstname    
  end
  
  def getLastName
    return @lastname
  end
  
end

#Grade class creates and gets the person's current grade standing
class Grade
  #Constructor
  def initialize(grade)
    @GradeStanding = grade 
  end
    
  #Getter
  def getGrade 
    return @GradeStanding
  end
    
end 

#StudentID class creates and gets the person's student ID  
class StudentID
    #Constructor
  def initialize(id)
    @studentID = id
  end
  
  #Getter
  def getStudentID
    return @studentID
  end
   
end  

#printing the students info
  person = Person.new("Angel", "Sanabria")
  name_first = person.getFirstName()
  name_last = person.getLastName()
  
  grade = Grade.new("Senior")
  gradestanding = grade.getGrade()
  
  studentid = StudentID.new("123456789")
  student_ID = studentid.getStudentID
  
  studentClasses = Array["CS471", "CS453", "CS354", "MATH301", "BIOL191"]
  
  puts "First Name: #{name_first}"
  puts "Last Name: #{name_last}"
  puts "Grade Standing: #{gradestanding}"
  puts "Student ID: #{student_ID}"
  puts "Classes:"
  puts studentClasses
