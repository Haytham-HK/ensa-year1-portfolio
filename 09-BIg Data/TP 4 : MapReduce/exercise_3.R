# --- Exercice 3 : Traitement d'un data.frame ---
library(rmr2)
rmr.options(backend = "local")

print("--- Execution de l'Exercice 3 : Traitement Data Frame ---")

# -- Exercice Principal --
y <- factor(c(1,1,2,1,2,3,1,2,3,2,1,1,2,3,3))
x_vals <- c(0.2,0.65,0.8,0.7,0.85,0.78,1.6,0.7,1.2,1.1,0.4,0.7,0.6,1.7,0.15)
donnees <- data.frame(y = y, x = x_vals)
donnees.dfs <- to.dfs(donnees)

# Fonction Map : emet (groupe, valeur)
map.rang <- function(., data) {
  keyval(data$y, data$x)
}

# Fonction Reduce : calcule la moyenne par groupe
reduce.moyenne <- function(k, v) {
  keyval(k, mean(v))
}

# Execution MapReduce
calcul_ex3 <- mapreduce(
  input = donnees.dfs,
  map = function(., data) keyval(data$y, data$x),
  reduce = function(k, v) keyval(k, mean(v))
)
resultat_ex3 <- from.dfs(calcul_ex3)
print("Resultat Exercice 3 (moyenne des valeurs par groupe) :")
print(resultat_ex3)

# -- Questions de l'Exercice 3 --

# Q3.1 : Retourner la variance des valeurs.
reduce.var <- function(k, v) { keyval(k, var(v)) }
resultat.q3.1 <- from.dfs(mapreduce(input = donnees.dfs, map = map.rang, reduce = reduce.var))
print("Resultat Q3.1 (variance des valeurs) :")
print(resultat.q3.1)

# Q3.2 : Retourner la moyenne et l'ecart-type.
reduce.moy.et <- function(k, v) { keyval(k, c(moyenne = mean(v), ecart_type = sd(v))) }
resultat.q3.2 <- from.dfs(mapreduce(input = donnees.dfs, map = map.rang, reduce = reduce.moy.et))
print("Resultat Q3.2 (moyenne et ecart-type) :")
print(from.dfs(resultat.q3.2, to.data.frame = TRUE))
