#Exercice !:

#1
Note <- c (12, 15, 18, 14, 16, 19, 17, 15, 14, 18)

#2
moyenne <- mean(Note)
print(paste("Mean : " , moyenne))

mediane <- median(Note)
print(paste("Median : ", moyenne))

ecart_type <- sd(Note)
print(paste('sd : ',ecart_type))

#3
etendue <- max(Note) - min(Note)
print(paste('range : ',etendue))

iqr <- IQR(Note)
print(paste('interquartile range : ',iqr))

#4
summary(Note)
