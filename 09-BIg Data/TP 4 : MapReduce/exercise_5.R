# --- Exercice 5 : Statistiques descriptives distribuees ---
library(rmr2)
rmr.options(backend = "local")

print("--- Execution de l'Exercice 5 : Statistiques Descriptives ---")

# -- Exercice Principal --
set.seed(42)
categories <- sample(c("A", "B", "C"), 100, replace = TRUE)
valeurs <- round(rnorm(100, mean = 50, sd = 15), 2)
donnees <- data.frame(cat = categories, val = valeurs)
donnees.dfs <- to.dfs(donnees)

# Fonction Map : emet (categorie, valeur)
map.stats <- function(., data) {
  keyval(data$cat, data$val)
}

# Fonction Reduce : calcule les statistiques
reduce.stats <- function(k, v) {
  stats <- c(
    n = length(v),
    moyenne = round(mean(v), 2),
    ecart_type = round(sd(v), 2),
    minimum = min(v),
    maximum = max(v)
  )
  keyval(k, paste(stats, collapse = " | "))
}

# Execution MapReduce
calcul_ex5 <- mapreduce(
  input = donnees.dfs,
  map = map.stats,
  reduce = reduce.stats
)
resultat_ex5 <- from.dfs(calcul_ex5)
print("Resultat Exercice 5 :")
print("Categorie | n | Moyenne | Ecart-type | Min | Max")
for (i in seq_along(resultat_ex5$key)) {
  print(paste(resultat_ex5$key[i], " | ", resultat_ex5$val[i]))
}

# -- Questions de l'Exercice 5 --

# Q5.2 : Retourner un data.frame au lieu d'une chaine.
reduce.stats.df <- function(k, v) {
  stats_df <- data.frame(
    n = length(v),
    moyenne = mean(v),
    ecart_type = sd(v),
    minimum = min(v),
    maximum = max(v)
  )
  keyval(k, stats_df)
}
res.q5.2 <- mapreduce(input = donnees.dfs, map = map.stats, reduce = reduce.stats.df)
print("Resultat Q5.2 (en data.frame) :")
print(from.dfs(res.q5.2))

# Q5.3 : Ajouter la mediane.
reduce.stats.mediane <- function(k, v) {
  stats <- c(
    n = length(v),
    moyenne = round(mean(v), 2),
    mediane = round(median(v), 2), # Mediane ajoutee
    ecart_type = round(sd(v), 2),
    minimum = min(v),
    maximum = max(v)
  )
  keyval(k, paste(stats, collapse = " | "))
}
res.q5.3 <- mapreduce(input = donnees.dfs, map = map.stats, reduce = reduce.stats.mediane)
print("Resultat Q5.3 (avec mediane) :")
print(from.dfs(res.q5.3))
