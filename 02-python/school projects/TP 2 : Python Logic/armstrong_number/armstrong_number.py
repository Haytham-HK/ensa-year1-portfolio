number = input('Enter the tree digit number : ')
first = int(number[0])
seconde = int(number[1])
third = int(number[2])
calcule = (first ** 3) + (seconde ** 3) + (third ** 3)
if calcule == int(number) :
    print (number,' is an Armstrong number.')
else :
    print (number,"is not an Armstrong number .")
