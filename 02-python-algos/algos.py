# algos.py
# First Python script for ENSA Year 1 porttfolio

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


#test 
if __name__ == "__main__":
 print("Factorial of 5 :" , factorial(5))
 print("First 10 fibonacci numbers : " , fibonacci(10))  

