def som_div_propre(n):

    i = 1
    som = 0

    while True:
        if i == n:
            break
        if n % i == 0:
            som += i  

        i += 1  

    return som


iter = 0  
n1 = 2  

while True:
    n2 = 0  
    n2 = som_div_propre(n1)
    if (
        som_div_propre(n2) == n1 and n1 != n2 and n1 <= n2
    ):  
        print(n1, n2, "ARE 'amicaux'")
        iter += 1
    if iter == 3:
        break
    n1 += 1
