from functools import reduce

numbers = [12, 45, 67, 34, 89, 23, 10, 5, 76]

even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
print(even_numbers)

squares = list(map(lambda x: x**2, even_numbers))
print(squares)

sum_of_evens = reduce(lambda x, y: x + y, even_numbers)
print(sum_of_evens)

students = [("Sara", 17), ("Ahmed", 12), ("Mohamed", 19), ("Meriam", 14)]

students_over_15 = list(filter(lambda x: x[1] > 15, students))
print(students_over_15)

student_names = list(map(lambda x: x[0], students))
print(student_names)
