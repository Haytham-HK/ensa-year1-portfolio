# --- Exercice 6 : Chainage de jobs MapReduce ---
library(rmr2)
rmr.options(backend = "local")

print("--- Execution de l'Exercice 6 : Chainage de Jobs ---")

lettres_ex6 <- c("A","B","C","A","C","D","B","A","C","D")
lettres_ex6.dfs <- to.dfs(lettres_ex6)

# Job 1 : Compter les lettres (comme l'exercice 1)
job1 <- mapreduce(
  input = lettres_ex6.dfs,
  map = function(., v) keyval(v, 1),
  reduce = function(k, v) keyval(k, sum(v))
)

# Job 2 : Trouver la lettre avec le comptage le plus eleve
# L'entree de ce job est l'objet HDFS du job1
map2 <- function(cle, val) {
  # Envoie toutes les paires cle-valeur a un seul reducteur
  keyval("max", data.frame(cle = cle, val = val, stringsAsFactors = FALSE))
}

reduce2 <- function(cle, val.df) {
  # Trouve la ligne avec la valeur maximale dans le data frame
  gagnant <- val.df[which.max(val.df$val), ]
  keyval(gagnant$cle, gagnant$val)
}

job2 <- mapreduce(
  input = job1,
  map = map2,
  reduce = reduce2
)

resultat_ex6 <- from.dfs(job2)
print("Resultat Exercice 6 (chainage pour trouver le max) :")
print(resultat_ex6)
