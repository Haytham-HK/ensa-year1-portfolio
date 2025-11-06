grades = [14, 16, 12, 19, 18]
grades.append(17)
grades.append(13)
print(grades)

i = grades.index(min(grades))
grades.pop(i)
print(grades)

print(sum(grades) / len(grades))

grades.sort()
grades.reverse()
print(grades)
