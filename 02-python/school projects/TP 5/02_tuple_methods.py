my_tuple = (12, 15, 18, 10, 15, 18, 17, 20)

count_15 = my_tuple.count(15)
print(count_15)

index_18 = my_tuple.index(18)
print(index_18)

sorted_list = sorted(my_tuple)
print(sorted_list)

min_val = min(my_tuple)
max_val = max(my_tuple)

print("The min is:", min_val)
print("The max is:", max_val)

is_14_present = 14 in my_tuple
print(is_14_present)

total_sum = sum(my_tuple)
print(total_sum)

students = (("Houda", 17), ("Ahmed", 12), ("Abdo", 19), ("Salma", 14))

print(sorted(students, key=lambda x: x[1], reverse=True))
print(max(students, key=lambda x: x[1]))
