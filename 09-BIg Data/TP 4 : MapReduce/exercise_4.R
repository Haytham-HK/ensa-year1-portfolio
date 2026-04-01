# --- Exercice 4 : Comptage de mots (Word Count) ---
library(rmr2)
rmr.options(backend = "local")

print("--- Execution de l'Exercice 4 : Comptage de Mots ---")

# -- Exercice Principal --
textes <- c(
  "le chat mange la souris",
  "la souris mange le fromage",
  "le chat dort sur le tapis",
  "le tapis est sur le sol"
)
textes.dfs <- to.dfs(textes)

# Fonction Map : decoupe les lignes en mots et emet (mot, 1)
map.mots <- function(., lignes) {
  mots <- unlist(strsplit(lignes, " "))
  mots <- tolower(mots)
  keyval(mots, 1)
}

# Fonction Reduce : somme les compteurs pour chaque mot
reduce.comptage <- function(mot, compteurs) {
  keyval(mot, sum(compteurs))
}

# Execution MapReduce
res.ex4 <- mapreduce(
  input = textes.dfs,
  map = map.mots,
  reduce = reduce.comptage
)

resultat_ex4 <- from.dfs(res.ex4)
df <- data.frame(mot = resultat_ex4$key, comptage = resultat_ex4$val)
df <- df[order(-df$comptage), ]
print("Resultat Exercice 4 (comptage de mots) :")
print(df)

# Q4.1 : Quel est le mot le plus frequent ?
print(paste("Mot le plus frequent (Q4.1) :", df$mot[1]))

# Q4.2 : Filtrer les mots de moins de 3 caracteres.
map.mots.filtres <- function(., lignes) {
  mots <- unlist(strsplit(lignes, " "))
  mots <- tolower(mots)
  mots <- mots[nchar(mots) >= 3] # Filtrage
  if (length(mots) > 0) {
    keyval(mots, 1)
  }
}
res.q4.2 <- mapreduce(input = textes.dfs, map = map.mots.filtres, reduce = reduce.comptage)
df.q4.2 <- from.dfs(res.q4.2, to.data.frame = TRUE)
df.q4.2 <- df.q4.2[order(-df.q4.2[,2]),]
print("Resultat Q4.2 (mots filtres >= 3 caracteres) :")
print(df.q4.2)

# Q4.3 : Pour utiliser un fichier, il faut d'abord le creer.
# writeLines(textes, "mon_fichier_texte.txt")
# Puis le charger :
# contenu_fichier <- readLines("mon_fichier_texte.txt")
# Et utiliser to.dfs(contenu_fichier) comme entree.

# Q4.4 (Bonus) : Chainer deux jobs MapReduce pour trouver le mot le plus frequent.
# C'est ce que fait l'Exercice 6. On le fait ici aussi.
# Job 1 est le meme que l'exercice principal (res.ex4).
# Job 2 trouve la valeur maximale.
map2.trouver.max <- function(., v) {
  # On envoie tous les comptages a un seul reducteur avec une cle constante.
  keyval("mot_max", v)
}
reduce2.trouver.max <- function(k, v) {
  # v est un data frame de mots et comptages
  # Trouver la ligne avec le comptage maximum
  meilleur_mot <- v[which.max(v$val), ]
  keyval(meilleur_mot$key, meilleur_mot$val)
}
# L'entree du second job est la sortie du premier job
res.q4.4 <- mapreduce(
  input = res.ex4, 
  map = map2.trouver.max,
  reduce = reduce2.trouver.max
)
print("Resultat Q4.4 (jobs chaines) :")
print(from.dfs(res.q4.4))
