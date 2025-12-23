fruits = {"apple", "banana", "orange", "kiwi"}

fruits.add("mango")
print(fruits)

fruits.remove("kiwi")
print(fruits)

fruits.discard("strawberry")  # No error if not found
print(fruits)

tropical = {"banana", "mango", "pineapple", "papaya"}

print(tropical.difference(fruits))

fruits.difference_update(tropical)
print(fruits)

green_fruits = {"apple", "kiwi", "pear"}

print(fruits.intersection(green_fruits))
print(fruits.union(green_fruits))
print(fruits.isdisjoint(green_fruits))
print(fruits.issuperset(green_fruits))
print(fruits.issubset(green_fruits))

print(fruits.pop())
print(fruits)
