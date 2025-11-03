#1
df <- data.frame(
   products = c ('P1','p2','p3','p4','p5'),
   sales = c (45, 52, 38, 61, 55),
   price = c (25, 30, 20, 35, 28))
print(df) 

#2
summary(df)

#3
plot(df$sales,df$price,
     main = "Sales price relation",
     xlab = "Sales",
     ylab = "Price")

fit <- lm ( df$price ~ df$sales , data = df$products )
abline ( fit , col = " red " , lwd =2)
