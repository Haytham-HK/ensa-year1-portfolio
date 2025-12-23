# Creates a vector
x <- c (1 , 2 , 3 , 4 , 5)
print ( x )

# vector with charachters
names <- c ( " Ali " , " Fatima " , " Ahmed " )
print ( names )

# logiaue vector
logique <- c ( TRUE , FALSE , TRUE )
print ( logique )


# create a matrice
matrix <- matrix (1:12 , nrow =3 , ncol =4)
print ( matrix )

# Create a datafreane
df <- data.frame (
  Name = c ( " Ali " , " Fatima " , " Ahmed " ) ,
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
print (c (addition, soustraction, multiplication, division))

data <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
# calculates moyenne
mean <- mean ( donnees )
print ( paste ( " mean : " , mean() ) )
# calculate moyenne
median <- median ( donnees )
print ( paste ( " Median : " , median ) )
# Mode
mode <- function ( x ) {
  ux <- unique ( x )
  ux [ which.max ( tabulate ( match (x , ux ) ) ) ]
}
print ( paste ( " Mode : " , mode ( donnees ) ) )


data <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
#tendue
etendue <- max ( donnees ) - min ( donnees )
print ( paste ( " range : " , etendue ) )
# Variance
variance <- var ( donnees )
print ( paste ( " Var : " , variance ) )
# cart - type
ecart_type <- sd ( donnees )
print ( paste ( " sd : " , ecart_type ) )
# variation coreficient
cv <- ( ecart_type / mean ( donnees ) ) * 100
print ( paste ( " Cv : " , cv , " % " ) )
# Quartiles and IQR
quartiles <- quantile ( donnees )
print ( quartiles )
iqr <- IQR ( donnees )
print ( paste ( " IQR : " , iqr ) )



data <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
# summary function for summary 
summary ( donnees )
# manual sumary
cat ( " ===== DESCRIPTIVE STATISTIQUES ===== \n " )
cat ( " observation numbers : " , length ( donnees ) , " \n " )
cat ( " Minimum : " , min ( donnees ) , " \n" )
cat ( " Q1 (25%) : " , quantile ( donnees , 0.25) , " \n " )
cat ( " Median ( Q2 ) : " , median ( donnees ) , " \n " )
cat ( " Mean : " , mean ( donnees ) , " \n " )
cat ( " Q3 (75%) : " , quantile ( donnees , 0.75) , " \n " )
cat ( " Maximum : " , max ( donnees ) , " \n " )
cat ( " sd : " , sd ( donnees ) , " \n " )


data <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
hist ( donnees ,
       main = " hist " ,
       xlab = " Values " ,
       ylab = " Frquency " ,
       col = " skyblue " ,
       border = " black " ,
       breaks =5)

donnees <- c (12 , 15 , 18 , 14 , 16 , 19 , 17 , 15 , 14 , 18)
boxplot ( donnees ,
          main = " boxplot " ,
          ylab = "Values " ,
          col = " lightcoral ")

x <- c (1 , 2 , 3 , 4 , 5 , 6)
y <- c (2 , 4 , 5 , 4 , 6 , 8)
plot (x , y ,
      main = " plot " ,
      xlab = " Variable X " ,
      ylab = " Variable Y " ,
      pch =19 ,
      col = " blue " ,
      cex =2)





