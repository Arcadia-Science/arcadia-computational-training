###############################################
### Write your function in the space below. ###
#### Then run the cell to check your work. ####

def fortune():
    flag1, flag2, flag3 = False, False, False
    
    while flag1 == False:
        name = input('What is your name? ')
        if name.isalpha():
            flag1 = True
            print('Nice to meet you, ' + str(name) + '.')
        else:
            print("Sorry... I don't quite understand.")
            print("Can you try again with alphabetic characters?")
    
    while flag2 == False:
        month = input('What month were you born in? ')
        
        months = ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december']
        
        if month.lower() in months:
            flag2 = True
            print('Ah... ' + str(month).title() + "... that's a very auspicious month.")
        else:
            print("Sorry, I don't think that's a month in the Gregorian calendar.")
            print("Can you try to remember?")
            
    while flag3 == False:
        day = input('And what day in ' + str(month).title() + ' were you born? ')
        day_num = float(day)
        
        if (day_num).is_integer():
            flag3 = True
            print('I see... ' + str(int(day_num)) + ' is a number with important meaning.')
        else:
            print("Sorry, I don't think that's quite right.")
            print("Could you try again?")
                
    print("I'm looking into your future...")
    lucky_number = (len(name) * len(month)) % int(day_num)
    print('It appears that your lucky number is ' + str(lucky_number) + '.')
    return lucky_number

###############################################

fortune()