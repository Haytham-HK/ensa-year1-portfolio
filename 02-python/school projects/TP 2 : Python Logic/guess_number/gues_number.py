import random
import sys

random_num = int(random.randint(1, 100))
i = 1

print("You have 10 trys")

for i in range(0, 10):
    while True:
        user_input = int(input("Enter a number between 1 et 100 : "))
        if user_input < 100:
            break

    if user_input < random_num:
        print("The random number is bigger ")
        print("Try again")
    elif user_input > random_num:
        print("The random number is smaller")
        print("Try again")
    elif user_input == random_num:
        print("Congrats,you've got it wright,it was", str(random_num))
        sys.exit()
    i += 1
print("You have failed to guess the correct number.")
print("The number was ", str(random_num))
