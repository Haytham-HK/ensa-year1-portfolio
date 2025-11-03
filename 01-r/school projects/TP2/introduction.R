# Creates a vector
x <- c (1 , 2 , 3 , 4 , 5)
print ( x )

# vector with charachters
noms <- c ( " Ali " , " Fatima " , " Ahmed " )
print ( noms )

# logiaue vector
logique <- c ( TRUE , FALSE , TRUE )
print ( logique )


# create a matrice
matrice <- matrix (1:12 , nrow =3 , ncol =4)
print ( matrice )

# Create a datafreane
df <- data.frame (
  Nom = c ( " Ali " , " Fatima " , " Ahmed " ) ,
  Age = c (20 , 21 , 22) ,
  Note = c (15 , 18 , 16)
)
print ( df)


# arithmitics operations
a <- 10
b <- 3
addition <- a + b
soustraction <- a - b
multiplication <- a * b
division <- a / b
puissance <- a ^ b
modulo <- a %% b
print ( c ( addition , soustraction , multiplication , division ) )


donnees <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
# calculates moyenne
moyenne <- mean ( donnees )
print ( paste ( " Moyenne : " , moyenne ) )
# calculate moyenne
mediane <- median ( donnees )
print ( paste ( " Mdiane : " , mediane ) )
# Mode
mode <- function ( x ) {
  ux <- unique ( x )
  ux [ which.max ( tabulate ( match (x , ux ) ) ) ]
}
print ( paste ( " Mode : " , mode ( donnees ) ) )


donnees <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
#tendue
etendue <- max ( donnees ) - min ( donnees )
print ( paste ( " tendue : " , etendue ) )
# Variance
variance <- var ( donnees )
print ( paste ( " Variance : " , variance ) )
# cart - type
ecart_type <- sd ( donnees )
print ( paste ( " cart-type : " , ecart_type ) )
# variation coreficient
cv <- ( ecart_type / mean ( donnees ) ) * 100
print ( paste ( " Coefficient de variation : " , cv , " % " ) )
# Quartiles and IQR
quartiles <- quantile ( donnees )
print ( quartiles )
iqr <- IQR ( donnees )
print ( paste ( " cart interquartile : " , iqr ) )



donnees <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
# summary function for summary 
summary ( donnees )
# manual sumary
cat ( " ===== STATISTIQUES DESCRIPTIVES ===== \n " )
cat ( " Nombre d ’ observations : " , length ( donnees ) , " \n " )
cat ( " Minimum : " , min ( donnees ) , " \n" )
cat ( " Q1 (25%) : " , quantile ( donnees , 0.25) , " \n " )
cat ( " M d i a n e ( Q2 ) : " , median ( donnees ) , " \n " )
cat ( " Moyenne : " , mean ( donnees ) , " \n " )
cat ( " Q3 (75%) : " , quantile ( donnees , 0.75) , " \n " )
cat ( " Maximum : " , max ( donnees ) , " \n " )
cat ( " cart - type : " , sd ( donnees ) , " \n " )


donnees <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
hist ( donnees ,
       main = " Histogramme des Donnes " ,
       xlab = " Valeurs " ,
       ylab = " Frquence " ,
       col = " skyblue " ,
       border = " black " ,
       breaks =5)

donnees <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
boxplot ( donnees ,
          main = " Biote Moustaches " ,
          ylab = " Valeurs " ,
          col = " lightcoral ")

x <- c (1 , 2 , 3 , 4 , 5 , 6)
y <- c (2 , 4 , 5 , 4 , 6 , 8)
plot (x , y ,
      main = " Diagramme de Dispersion " ,
      xlab = " Variable X " ,
      ylab = " Variable Y " ,
      pch =19 ,
      col = " blue " ,
      cex =2)





