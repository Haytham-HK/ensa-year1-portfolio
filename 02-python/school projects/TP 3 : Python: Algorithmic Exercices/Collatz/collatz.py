n = int(input("Enter a number: ")) 

iter = 0

while not n == 1:
    if n % 2 == 0:
        n = n / 2 
        iter += 1
        print(n)
    else:
        n = n * 3 + 1
        iter += 1
        print(n)

print("total number of iterations :", iter)