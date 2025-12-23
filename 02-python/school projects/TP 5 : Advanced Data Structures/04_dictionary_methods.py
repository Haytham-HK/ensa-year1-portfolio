student = {"name": "Sara", "age": 20, "grade": 17, "class": "IACS"}

print(student.get("grade"))
print(student.get("address"))
print(student.keys())
print(student.values())

keys = student.keys()
for i in keys:
    print(student.get(i))

student["grade"] = 18
student["email"] = "alice@example.com"
student.update(city="Casablanca", phone="0612345678")

print(student.pop("class"))
print(student.pop("last_name", "error"))
print("name" in student)
print(len(student))

student_copy = student.copy()
print(student_copy)

student.clear()
print(student)
