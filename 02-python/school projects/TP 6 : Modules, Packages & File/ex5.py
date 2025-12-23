import xml.etree.ElementTree as xml

with open("students.xml", "r") as f:
    students = xml.parse(f)
    root = students.getroot()
    for student in root.findall("student"):
        name = student.find("name").text
        grade = student.find("grade").text
        print(name)
        print(grade)

student = xml.Element("student")

name = xml.SubElement(student, "name")
name.text = "student"

grade = xml.SubElement(student, "grade")
grade.text = "88"

root.append(student)

students.write("students.xml", encoding="utf-8", xml_declaration=True)
