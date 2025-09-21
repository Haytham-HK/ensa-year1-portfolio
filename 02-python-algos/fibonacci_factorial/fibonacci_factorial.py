# A factorial and fibonacci function code 


#factorial function
def factorial(n):
  if  n == 0 or n ==1:
     return 1
  else:
   return n * factorial(n-1)
#Example: factorial(5) = 5 × 4 × 3 × 2 × 1 = 120.
 

#fibonacci function
def fibonacci(n):
   seq = [0,1]  #first sequence numbers
   for i in range(2,n):
    next_number = seq[i-1] + seq [i-2]
    seq.append(next_number)
   return seq


n = input ("enter your number : ")
fact = factorial(int(n))
fib = fibonacci(int(n))
print(f'the factorial of {n} is {fact}')
print(f'the fibonacci of {n} is {fib}')

