#Exercice !:

#1
Note <- c (12, 15, 18, 14, 16, 19, 17, 15, 14, 18)

#2
moyenne <- mean(Note)
print(paste("Moyenne : " , moyenne))

mediane <- median(Note)
print(paste("Mediane : ", moyenne))

ecart_type <- sd(Note)
print(paste('Ecart_type : ',ecart_type))

#3
etendue <- max(Note) - min(Note)
print(paste('Tendue : ',etendue))

iqr <- IQR(Note)
print(paste('Ecart interquartile : ',iqr))

#4
summary(Note)
