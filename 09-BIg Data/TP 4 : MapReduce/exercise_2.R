# --- Exercice 2 : Comptage de valeurs paires et impaires ---
library(rmr2)
rmr.options(backend = "local")

print("--- Execution de l'Exercice 2 : Comptage Pairs/Impairs ---")

# -- Exercice Principal --
x <- c(2, 6, 67, 85, 7, 9, 4, 21, 78, 45)
x.dfs <- to.dfs(x)

# Fonction Map : cle = 1 pour pair, 2 pour impair
map_valeurs <- function(., v) {
  cle <- ifelse(v %% 2 == 0, 1, 2)
  keyval(cle, v)
}

# Fonction Reduce : compte le nombre de valeurs par categorie
reduce_valeurs <- function(k, v) {
  keyval(k, length(v))
}

# Execution MapReduce
calcul <- mapreduce(
  input = x.dfs,
  map = map_valeurs,
  reduce = reduce_valeurs
)
resultat_ex2 <- from.dfs(calcul)
print("Resultat Exercice 2 (1=pair, 2=impair) :")
print(resultat_ex2)

# -- Questions de l'Exercice 2 --

# Q2.1 : Calculer la somme au lieu du comptage.
reduce_somme <- function(k, v) { keyval(k, sum(v)) }
resultat.q2.1 <- from.dfs(mapreduce(input = x.dfs, map = map_valeurs, reduce = reduce_somme))
print("Resultat Q2.1 (somme) :")
print(resultat.q2.1)

# Q2.2 : Calculer la moyenne.
reduce_moyenne <- function(k, v) { keyval(k, mean(v)) }
resultat.q2.2 <- from.dfs(mapreduce(input = x.dfs, map = map_valeurs, reduce = reduce_moyenne))
print("Resultat Q2.2 (moyenne) :")
print(resultat.q2.2)

# Q2.3 : Creer 3 groupes : "petit" (<10), "moyen" (10-50), "grand" (>50).
map_groupes <- function(., v) {
  cle <- cut(v, breaks = c(-Inf, 9, 50, Inf), labels = c("petit", "moyen", "grand"))
  keyval(as.character(cle), 1) # Emet 1 pour chaque valeur pour les compter
}
reduce_comptage <- function(k, v) { keyval(k, sum(v)) }
resultat.q2.3 <- from.dfs(mapreduce(input = x.dfs, map = map_groupes, reduce = reduce_comptage))
print("Resultat Q2.3 (groupes) :")
print(resultat.q2.3)
