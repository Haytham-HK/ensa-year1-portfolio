with open("students.txt", "r") as students:
    print(students.readlines())
    for line in students:
        print(line.strip().split(", "))


with open("students.txt", "r") as students:
    moyenne_note = total_notes = 0
    num_students = 0
    students_list = students.readlines()
    for ligne in students_list:
        ligne_age_nom_separe = ligne.split(", ")
        note = int(ligne_age_nom_separe[1])
        total_notes += note
        num_students += 1
    moyenne_note = total_notes / num_students
print(moyenne_note)

with open("average.txt", "w") as average:
    average.write(str(moyenne_note))
