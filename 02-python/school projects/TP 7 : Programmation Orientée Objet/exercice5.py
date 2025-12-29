class errorMoteur(Exception):
    def __init__(self, message):
        self.message = message
        super().__init__(self.message)

    def __str__(self):
        return f"errorMoteur: {self.message}"


class Moteur:
    def __init__(self, puissance, type_demarrage):
        self.puissance = puissance
        self.type_demarrage = type_demarrage

    def demarrer(self):
        return f"demare avec : {self.type_demarrage}"


class Voiture:
    def __init__(self, marque, moteur, moteur_demarre):
        self.marque = marque
        self.moteur = moteur
        self.moteur_demarre = moteur_demarre

    def demarrer_voiture(self):
        return f"{self.marque} {self.moteur.demarrer()}"


class Garage:
    def __init__(self):
        self.voitures = []
        self.nbr_voitures = 0

    def ajouter_voiture(self, voiture):
        self.voitures.append(voiture)

    @property
    def nbr_voitures(self):
        return len(self.voitures)

    @nbr_voitures.setter
    def nbr_voitures(self, value):
        self._nbr_voitures = value


moteur1 = Moteur(200, "cle")
dacia = Voiture("Dacia", moteur1, True)
print(dacia.demarrer_voiture())

moteur2 = Moteur(300, "bouton")
ford = Voiture("Ford", moteur2, False)

if not ford.moteur_demarre:
    print(errorMoteur("Le moteur ne peut pas demarrer"))
else:
    print(ford.demarrer_voiture())

garage = Garage()
garage.ajouter_voiture(dacia)
garage.ajouter_voiture(ford)
garage.nbr_voitures = 2
print(f"Nombre de voitures dans le garage : {garage.nbr_voitures}")
