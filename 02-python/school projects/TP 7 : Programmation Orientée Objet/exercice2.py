class CompteBancaire:
    def __init__(self, titulaire, solde):
        self.titulaire = titulaire
        self._solde = solde

    def deposer(self, montant):
        self._solde = self._solde + montant

    def retirer(self, montant):
        if montant > self._solde:
            print("Solde insufisant")
        else:
            self._solde = self._solde - montant

    def afficher_solde(self):
        print(f"Votre solde est {self._solde} ")

    def __str__(self):
        return f"Compte bancaire de {self.titulaire} - Solde : {self._solde} DH"


compte = CompteBancaire("Haytham", 2000)
compte.retirer(5000)
compte.afficher_solde()
print(compte)
