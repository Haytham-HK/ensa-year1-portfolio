print("a divided by b")

a = int(input("Enter a (positif) : "))
b = int(input("Enter b (positif différent from 0 : "))

i = 0

while a >= 0:
    a = a - b
    if a >= 0:
        i += 1

print(i)