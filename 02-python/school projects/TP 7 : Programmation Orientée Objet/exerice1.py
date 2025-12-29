class Personne:
    def __init__(self, nom, age):
        self.nom = nom
        self.age = age

    def se_presenter(self):
        print(f"Bounjour, je m'appelle {self.nom} et j'ai {self.age} ans.")


p1 = Personne("Haytham", 20)
p2 = Personne("KENNOUZ", 21)
p1.se_presenter()
p2.se_presenter()
