def is_kaprekar(n):
    if n == 1:
        return True
    puissance = str(n**2)
    d = len(puissance)
    if d <= 1:
        return False 
    left = puissance[0:d//2]
    right = puissance[d//2:d]
    if int(right) == 0:
        return False

    somme = int(left) + int(right)

    if n == somme:
        return True
    else:
        return False


num = int(input("Enter a positif number : "))
if is_kaprekar(num):
    print(num, "is a kaprekar number.")
else:
    print(num, "is not a kaprekar number.")

num = 1
i = 0

while True:
    if is_kaprekar(num):
        print(num, 'is a kaprekar number .')
        i += 1
    if i == 10:
        break
    num += 1
