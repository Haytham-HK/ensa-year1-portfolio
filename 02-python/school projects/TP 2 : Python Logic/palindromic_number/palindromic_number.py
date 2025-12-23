number = int(input("Enter your number : "))
print_num = number

"""Rappel :
   12 / 10 = 1,2 , returns float
   12 // 10 = 1 , returns int
   12 % 10 = 2, returns the rest 
"""

revers = 0
while number != 0:  # for exammple 14
    i = (
        number % 10
    )  # The rest of division is the last number,  first time :  4 , seconde : 1
    revers = revers * 10  # to make last iteration number, first-time : 0 , second : 40
    revers = revers + i  # to add last number to its place, first-time : 4 , second : 41
    number = number // 10  # to eliminate the last number,  first-time : 1 ,second : 0

if revers == print_num:
    print(print_num, "is a palindrom")
else:
    print(print_num, "is not a palindrome")
