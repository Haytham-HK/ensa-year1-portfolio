class Animal:
    def __init__(self, nom, methode_de_parler):
        self.nom = nom
        self.methode_de_parler = methode_de_parler


class Chien(Animal):
    def parler(self):
        return "Woof Woof"


class Chat(Animal):
    def parler(self):
        return "Miaou Miaou"


chien = Chien("Rex", "aboyer")
chat = Chat("Whiskers", "miauler")

print(chien.parler())
print(chat.parler())
