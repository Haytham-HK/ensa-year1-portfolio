import json

data = {
    "employees": [
        {"name": "Rania", "age": 30, "position": "Developer"},
        {"name": "Ahmed", "age": 25, "position": "Designer"},
        {"name": "Salma", "age": 35, "position": "Manager"},
    ]
}

with open("data.json", "w") as data_j:
    json.dump(data, data_j)

with open("data.json", "r") as data_j:
    data_charge = json.load(data_j)

for i in data_charge["employees"]:
    print(i["name"])

nouveau = {"name": "Hayham", "age": 19, "position": "Stagaire"}
data_charge["employees"].append(nouveau)


with open("data.json", "w") as data_j:
    json.dump(data_charge, data_j)
