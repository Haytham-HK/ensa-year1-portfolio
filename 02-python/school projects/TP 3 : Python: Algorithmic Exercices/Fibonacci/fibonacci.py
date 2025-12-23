F1 = input("Enter the first number F1 : ")
F2 = input("Enter the second number F2 : ")
n = int(input("Enter the number of iterations: "))

if n == 1 :
    resultat = F1
    print("The result is: ", resultat)
elif n == 2 :
    resultat = F2
    print("The result is: ", resultat)
else :
    for i in range(2, n) :
        resultat = int(F1)**2 + int(F2)**2
        F1 = F2
        F2 = resultat
    print("the result is: ", resultat)


