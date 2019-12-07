#This class displays an online menu for a diner. This class takes in user input to see which
#menu of the day will be shown 
class OnlineMenu
  
  #Array of breakfast menus for each day of the week
  mondayBreakfast = Array["Eggs and Sausage", "French Toast and Pancakes", "French Toast and Waffles",
  "Coffee", "Orange Juice"]
  tuesdayBreakfast = Array["Eggs and Sausage", "Pancakes and Waffles", "Cereal",
    "Coffee", "Orange Juice"]
  wednesdayBreakfast = Array["Eggs and Sausage", "Bagel with Cream Cheese", "Chicken and Waffles",
    "Coffee", "Orange Juice"]
  thursdayBreakfast = Array["Eggs and Sausage", "Peanut Butter and Jelly Sandwich", "Scones with Hot Chocolate",
    "Coffee", "Orange Juice"]
  fridayBreakfast = ["Eggs and Sausage", "Bagel with Cream Cheese", "Chicken and Waffles",
  "Coffee", "Orange Juice"]
  saturdayBreakfast = Array["Cereal", "French Toast and Pancakes", "French Toast and Waffles",
    "Coffee", "Orange Juice"]
  sundayBreakfast = Array["Eggs and Sausage", "Oatmeal", "French Toast and Waffles",
    "Coffee", "Orange Juice"]
    
  #Array of lunch menus for each day of the week
    mondayLunch = Array["Club Sandwich", "Hot Cabbage Soup", "BLT",
    "Coffee", "Orange Juice", "Soda of your choice", "Milkshake"]
    tuesdayLunch = Array["Hamburger with fries", "Bacon Cheese Burger with fries", "Cheese Burger with fries",
      "Coffee", "Orange Juice", "Soda of your choice", "Milkshake"]
    wednesdayLunch = Array["Grilled Cheese Sandwich", "Tuna Sandwich", "BLT",
      "Coffee", "Orange Juice", "Soda of your choice", "Milkshake"]
    thursdayLunch = Array["Ham Sandwich", "Turkey Sandwich", "Pastrami Sandwich",
      "Coffee", "Orange Juice", "Soda of your choice", "Milkshake"]
    fridayLunch = Array["Hamburger with fries", "Bacon Cheese Burger with fries", "Cheese Burger with fries",
  "Coffee", "Orange Juice", "Soda of your choice", "Milkshake"]
    saturdayLunch = Array["Hamburger with fries", "Bacon Cheese Burger with fries", "Cheese Burger with fries",
  "Coffee", "Orange Juice", "Soda of your choice", "Milkshake"]
    sundayLunch = Array["Grilled Cheese Sandwich", "Tuna Sandwich", "BLT",
  "Coffee", "Orange Juice", "Soda of your choice", "Milkshake"]
      
  #Array of dinner menus for each day of the week
    mondayDinner = Array["Steak and Potatoes", "Salmon on Rice", "Lasagna",
    "Coffee", "Orange Juice", "Soda of your choice", "Wine"]
    tuesdayDinner = Array["Pasta with Pesto Sauce", "Pasta with Alfredo Sauce", "Pasta with Marinara Sauce",
      "Coffee", "Orange Juice", "Soda of your choice", "Wine"]
    wednesdayDinner = Array["Chicken and Pasta", "Pork Roast", "Lamb Chops with Vegetables",
      "Coffee", "Orange Juice", "Soda of your choice", "Wine"]
    thursdayDinner = Array["Steak with Mashed Potatoes and Gravy", "Spaghetti", "Fillet Minion",
      "Coffee", "Orange Juice", "Soda of your choice", "Wine"]
    fridayDinner = Array["Turkey Breast with Mashed Potatoes and Gravy", "Talapia on Rice", "Steak and Grits",
      "Coffee", "Orange Juice", "Soda of your choice", "Wine"]
    saturdayDinner = Array["Pasta with Pesto Sauce", "Pasta with Alfredo Sauce", "Pasta with Marinara Sauce",
  "Coffee", "Orange Juice", "Soda of your choice", "Wine"]
    sundayDinner = Array["Steak and Potatoes", "Salmon on Rice", "Lasagna",
  "Coffee", "Orange Juice", "Soda of your choice", "Wine"]     
  
  #Asks the user which menu from the week they would like to see      
  puts "Would you like to see our online menu? We have different menus for each day. 
  Which menu from the week would you like to see?"
  menuDay = gets.chomp()
  puts"\n"
  
  #If statements to check which day of the week the user would like to see
  if (menuDay == "Monday" || menuDay == "monday")
    puts"BreakFast Menu for Monday:"
    puts mondayBreakfast
    puts"\n"
    puts"Lunch Menu for Monday:"
    puts mondayLunch
    puts"\n"
    puts"Dinner Menu for Monday:"
    puts mondayDinner
  end
  
  if (menuDay == "Tuesday" || menuDay == "tuesday")
      puts"BreakFast Menu for Tuesday:"
      puts tuesdayBreakfast
      puts"\n"
      puts"Lunch Menu for Tuesday:"
      puts tuesdayLunch
      puts"\n"
      puts"Dinner Menu for Tuesday:"
      puts tuesdayDinner
    
  end
  
  if (menuDay == "Wednesday" || menuDay == "wednesday")
      puts"BreakFast Menu for Wednesday:"
      puts wednesdayBreakfast
      puts"\n"
      puts"Lunch Menu for Wednesday:"
      puts wednesdayLunch
      puts"\n"
      puts"Dinner Menu for Wednesday:"
      puts wednesdayDinner
    
  end
  
  if (menuDay == "Thursday" || menuDay == "thursday")
      puts"BreakFast Menu for Thursday:"
      puts thursdayBreakfast
      puts"\n"
      puts"Lunch Menu for Thursday:"
      puts thursdayLunch
      puts"\n"
      puts"Dinner Menu for Thursday:"
      puts thursdayDinner
    
  end
  
  if (menuDay == "Friday" || menuDay == "friday")
      puts"BreakFast Menu for Friday:"
      puts fridayBreakfast
      puts"\n"
      puts"Lunch Menu for Friday:"
      puts fridayLunch
      puts"\n"
      puts"Dinner Menu for Friday:"
      puts fridayDinner
    
  end
  
  if (menuDay == "Saturday" || menuDay == "saturday")
      puts"BreakFast Menu for Saturday:"
      puts saturdayBreakfast
      puts"\n"
      puts"Lunch Menu for Saturday:"
      puts saturdayLunch
      puts"\n"
      puts"Dinner Menu for Saturday:"
      puts saturdayDinner
    
  end
  
  if (menuDay == "Sunday" || menuDay == "sunday")
      puts"BreakFast Menu for Sunday:"
      puts sundayBreakfast
      puts"\n"
      puts"Lunch Menu for Sunday:"
      puts sundayLunch
      puts"\n"
      puts"Dinner Menu for Sunday:"
      puts sundayDinner
    
  end
    
end