# Exploratory Data Analysis_intro.R
#First R script for ENSA Year 1 portofolio

#First lets load built-in dataset 
data(iris)

#Then printing a summary of the data set
print(summary(iris))

#A simple plot
plot(iris$Sepal.Length , iris$Sepal.Width ,
     main = "Iris Sepal Lenght vs width",
     xlab = "Sepal Lenght" ,
     ylab = "Sepal Width" ) 
