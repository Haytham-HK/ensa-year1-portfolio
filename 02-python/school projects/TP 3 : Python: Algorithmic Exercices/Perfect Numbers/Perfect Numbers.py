print ('The list of the first 5 perfect number :')
ite = 0
num = 2
while ite <= 4 :  
    somm = 0
    i = 1
    while i < num : 
        if (num // i ) == (num / i ) : 
            somm = somm + i
        i = i + 1   
    if somm == num :  
        print(num, "is a perfect number")
        ite = ite + 1
    num = num + 1