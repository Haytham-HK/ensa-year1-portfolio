# --- Exercice 1 : Comptage de lettres ---
library(rmr2)
rmr.options(backend = "local")

print("--- Execution de l'Exercice 1 : Comptage de Lettres ---")

# -- Exercice Principal --
lettres <- c("A", "A", "A", "B","A", "B","B","A", "B", "B","A","A","A", "B","B","B","A","A")
lettres_dfs <- to.dfs(lettres)

# Fonction Map : emet une paire (lettre, 1) pour chaque lettre
mon.map <- function(., v) {
  keyval(v, 1)
}

# Fonction Reduce : somme toutes les valeurs pour chaque cle
mon.reduce <- function(k, v) {
  keyval(k, sum(v))
}

# Execution du job MapReduce
resultat.mr <- mapreduce(
  input = lettres_dfs,
  map = mon.map,
  reduce = mon.reduce
)

resultat <- from.dfs(resultat.mr)
print("Resultat de l'Exercice 1 :")
print(resultat)


# -- Questions de l'Exercice 1 --

# Q1.1 : Que se passe-t-il si on remplace sum(v) par length(v) ?
# Le resultat est identique car la fonction Map emet un '1' pour chaque lettre.
# La somme de tous les '1' pour une lettre donnee est equivalente a les compter (length).
q1.1.reduce <- function(k, v) {
  keyval(k, length(v))
}
resultat.q1.1 <- from.dfs(mapreduce(input = lettres_dfs, map = mon.map, reduce = q1.1.reduce))
print("Resultat Q1.1 (avec length) :")
print(resultat.q1.1)

# Q1.3 : Modifier le programme pour un nouveau vecteur.
lettres_q1.3 <- c("A", "B", "C", "A", "C", "D", "B", "A", "C", "D")
resultat.q1.3 <- from.dfs(mapreduce(input = to.dfs(lettres_q1.3), map = mon.map, reduce = mon.reduce))
print("Resultat Q1.3 (nouveau vecteur) :")
print(resultat.q1.3)

# Q1.4 (Bonus) : Trouver la lettre la plus frequente.
# Ceci est fait sur le resultat final, pas avec MapReduce.
plus.frequente <- resultat$key[which.max(resultat$val)]
print(paste("Lettre la plus frequente (Q1.4) :", plus.frequente))
