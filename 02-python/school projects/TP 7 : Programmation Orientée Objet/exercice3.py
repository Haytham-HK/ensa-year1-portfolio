class Employe:
    def __init__(self, nom, salaire):
        self.nom = nom
        self.salaire = salaire

    def calculer_salaire(self):
        return self.salaire


class EmployePermanent(Employe):
    def calculer_salaire(self):
        return self.salaire


class EmployeTemporaire(Employe):
    def __init__(self, nom, salaire, nombre_heures, tarif_horaire):
        super().__init__(nom, salaire)
        self.nombre_heures = nombre_heures
        self.tarif_horaire = tarif_horaire

    def calculer_salaire(self):
        return self.nombre_heures * self.tarif_horaire


emp1 = EmployePermanent("Haytham", 8000)
emp2 = EmployeTemporaire("kennouz", 0, 20, 400)

print(emp1.calculer_salaire())
print(emp2.calculer_salaire())
