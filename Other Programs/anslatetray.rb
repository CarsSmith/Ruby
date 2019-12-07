# This program asks the user to input something and translates it into pig latin.
# This is not a perfect translator, as one of the rules of pig latin revolves around
# phonetics and not pure spelling (referring to cases around the letter 'y')
# In these cases, the program simply treats "y" like a consonant.

# Author: Carson Smith, written for CS354 LW1 in Fall 2019

def anslatetray()
    puts "Please enter what you would like to translate:"
    input = gets
    word_array = input.split
    word_array.map! {|word| anslatetray_ordway(word)}
    result = word_array.join(" ")
    puts result
end

# Pig latin for translate_word. It takes a word and returns the word in pig latin.
def anslatetray_ordway(word)
  if word.match? /[a-zA-Z]+/  # Using a regex to check if the string contains only letters.
    if is_vowel(word[0])
      #Vowel case
      word = "#{word}" + "way"  # Pig latin here is just the word with "way" added to the end of it.
    else 
      #Consonant case
      cons_num = number_of_leading_consonants(word)
      firstpart = word[0...cons_num]
      secondpart = word[cons_num...word.length]
      word = "#{secondpart}#{firstpart}" + "ay"  #In this case the word is swapped around and "ay" is added to the end.
    end
  else
    word # Just return the word alone without modification if it doesn't contain any letters.
  end
end

# A simple method that calculates the number of consonant characters in a word before the first instance of a vowel
# If there are no vowels in the input, it will return the length of the word.
def number_of_leading_consonants(word)
  count = 0
  while (is_vowel(word[count]) == false) # While it's not a vowel...
    count += 1         
    break if count == word.length       # Don't continue if it's reached the end of the word.
  end
  return count
end

# A simple checking method to see if a character is a vowel or not.
# It's effectively commonsense if-statement logic.
def is_vowel(character)
  character = character.downcase
  if character == "a" || character == "e" || character == "i"  || character == "o" || character == "u"
    true
  else
    false
  end
end

anslatetray()