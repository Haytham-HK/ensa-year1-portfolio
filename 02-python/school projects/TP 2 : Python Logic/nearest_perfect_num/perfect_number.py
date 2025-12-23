import sys
def parfait(n):
    som = 0
    for i in range(1, n):
        if n % i == 0:
            som = som + i
    if som == n:
        return True
    else:
        return False


num = int(input("Enter your number :"))
incre = 1

while True:
    liste = [num - incre, num + incre]
    for j in liste:
        if parfait(j):
            print("The nearest perfect number is : ", j)
            sys.exit()
    incre = incre + 1
