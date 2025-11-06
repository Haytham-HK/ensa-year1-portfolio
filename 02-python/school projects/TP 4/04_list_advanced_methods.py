# Part 1:
print("Part 1:")
num_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(num_list)

num_list.append(11)
num_list.append(12)
print(num_list)

num_list.insert(0, 0)
print(num_list)

num_list.pop(-1)
print(num_list)

print("The index of 5 is", num_list.index(5))

for i in range(len(num_list)):
    num_list[i] = num_list[i] * 2
print(num_list)

# Part 2:
print("Part 2:")
fruits = ["apple", "banana", "orange", "kiwi", "mango"]

fruits.sort()
print(fruits)

fruits.append("mango")
print(fruits)

if fruits.count("kiwi") == 0:
    print("Kiwi is not in the list")
else:
    print("Kiwi is in the list")

fruit = input("Enter the name of a fruit to remove: ")
if fruit in fruits:
    fruits.remove(fruit)
else:
    print("The fruit is not in the list.")
print(fruits)
