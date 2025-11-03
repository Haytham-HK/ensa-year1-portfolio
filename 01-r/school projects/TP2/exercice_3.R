#1
df <- data.frame(
   Nom = c ('P1','p2','p3','p4','p5'),
   ventes = c (45, 52, 38, 61, 55),
   prix = c (25, 30, 20, 35, 28))
print(df) 

#2
summary(df)

#3
plot(df$ventes,df$prix,
     main = "Vente et produit relation",
     xlab = "Vente",
     ylab = "Produit")

fit <- lm ( df$prix ~ df$ventes , data = df$noms )
abline ( fit , col = " red " , lwd =2)
