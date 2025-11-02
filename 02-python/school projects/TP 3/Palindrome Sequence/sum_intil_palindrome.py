def is_palindrome(number):
    # from tp 2 .
    original = number
    revers = 0
    while number > 0:
        digit = number % 10
        revers = revers * 10
        revers += digit
        number //= 10
    if revers == original:
        return True
    else:
        return False


n = int(input("Enter a positif number : "))

iterations = 0
while not is_palindrome(n):
    digit_sum = 0
    n_str = str(n)
    for digit in n_str:
        digit_sum += int(digit)
    n += digit_sum
    iterations += 1

print("The final number", n)
print("The number of itteration :", iterations)
