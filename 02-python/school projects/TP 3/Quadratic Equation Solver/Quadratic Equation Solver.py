import math


a = float(input("Enter the first number:"))
b = float(input("Enter the seconde number :"))
c = float(input("Enter the third number :"))


if a == 0:
    
    if b == 0:
        if c == 0:
            print('0 = 0')
        else:
            print('Impossible')
    else:
        result = -c / b
        print("The equation has no solution")
        print('The result is', result)


else:
    delta = b**2 - 4*a*c

    if delta == 0:
        print('The equation has one solution')
        result = -b / (2*a)
        print('The result is', result)
        
    elif delta > 0:
        print('The equation has two solutions:')
        result_1 = (-b + math.sqrt(delta)) / (2*a)
        result_2 = (-b - math.sqrt(delta)) / (2*a)
        print(result_1)
        print(result_2)
        
    else :
        print ('la solution est complexe')