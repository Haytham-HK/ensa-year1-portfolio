# --- Section 1: First Steps in R ---

# 1.1. Basic calculations and sequences
print("Result of pi * sqrt(10) + exp(4):")
print(pi * sqrt(10) + exp(4))

print("Sequence from 3 to 10:")
print(3:10)

print("Sequence from 3 to 10 (with seq):")
print(seq(3, 10))

# 1.2. Vectors
x <- c(2, 3, 5, 7, 2, 1)
y <- c(10, 15, 12)
z <- c(x, y) # Concatenate x and y

print("Vector x:")
print(x)
print("Vector z (x and y combined):")
print(z)

# 1.3. Vector operations
print("z squared (element-wise):")
print(z^2)

print("x times x (element-wise):")
print(x * x)

# 1.4. Vector repetition
w_rep <- rep(x, 3) # Repeat vector x 3 times
w_each <- rep(x, each = 3) # Repeat each element of x 3 times

print("Repetition (rep):")
print(w_rep)
print("Repetition (rep, each):")
print(w_each)

# --- Section 2: Matrices ---

# Create from a vector
x_mat <- 1:12
dim(x_mat) <- c(3, 4) # Reshape vector into a 3x4 matrix
print("Matrix created with dim():")
print(x_mat)

# Create with the matrix() function
y_mat <- matrix(1:12, nrow = 3, byrow = TRUE)
print("Matrix created with matrix() (byrow=TRUE):")
print(y_mat)

# Transpose
print("Transpose of y_mat:")
print(t(y_mat))

# Matrix operations
z_mat <- matrix(1:4, nrow = 2, byrow = TRUE)
print("Matrix z_mat (2x2):")
print(z_mat)

print("z_mat * z_mat (element-wise multiplication):")
print(z_mat * z_mat)

print("z_mat %*% z_mat (matrix multiplication):")
print(z_mat %*% z_mat)

# --- Section 3: Plotting ---

set.seed(42) # Added for reproducibility
x_plot <- runif(50, 0, 2)
y_plot <- runif(50, 0, 2)

print("Generating a basic plot (see plot window).")
# dev.new() # Uncomment to open a new plot window
plot(x_plot, y_plot,
     main = "Graph Title",
     xlab = "X-axis label",
     ylab = "Y-axis label",
     col = "darkred",
     pch = 19) # pch=19 for solid circles

# Add lines and text
abline(h = .6, v = .6, col = "blue", lty = 2) # lty=2 for dashed line
text(.6, .6, "Intersection (0.6, 0.6)", pos = 4) # pos=4 for text to the right

# --- Section 4: Random Simulation ---

set.seed(123) # Added for reproducibility

print("10 samples from N(0,1):")
print(rnorm(10))

# plot(rnorm(100), type='l', main="N(0,1) Simulation")

print("10 samples from Binomial(size=20, prob=0.5):")
print(rbinom(10, size = 20, prob = .5))

print("10 samples from Cauchy distribution:")
print(rcauchy(10))

print("10 samples from Uniform(min=0, max=1):")
print(runif(10, min = 0, max = 1))

print("Sample without replacement (5 from 1:40):")
print(sample(1:40, 5))

print("Sample with replacement (10 from 1:10):")
print(sample(1:10, 10, replace = TRUE))

print("Weighted probability sample:")
print(sample(c("failure", "success"), 10, replace = TRUE, prob = c(0.7, 0.3)))

# --- Section 5: Empirical Descriptions ---

set.seed(456)
x_desc <- rnorm(100)
n <- length(x_desc)

# 5.1. Empirical distribution function
print("Generating empirical distribution plot.")
# dev.new()
plot(sort(x_desc), 1:n / n,
     type = "s", # "s" for step plot
     ylim = c(0, 1),
     xlab = "x",
     ylab = "Fn(x)",
     main = "Empirical vs. Theoretical Distribution")
# Add theoretical N(0,1) distribution
curve(pnorm(x, 0, 1), add = TRUE, col = "blue", lwd = 2)
legend("bottomright", legend = c("Empirical (Fn)", "Theoretical (pnorm)"),
       col = c("black", "blue"), lty = 1, lwd = c(1, 2))

# 5.2. Histogram
print("Generating histogram with density curve.")
# dev.new()
hist(x_desc, breaks = 20, freq = FALSE, col = "cyan",
     main = "Histogram and Theoretical N(0,1) Density")
# Add theoretical density curve
curve(dnorm(x), add = TRUE, col = "darkblue", lwd = 2)

# 5.3. Boxplot
print("Generating comparative boxplots.")
y_desc <- (rnorm(400))^2 - 1
z_desc <- rnorm(50)^3

# dev.new()
par(bg = "lightcyan") # Change background color
boxplot(x_desc, y_desc, z_desc,
        col = c("blue", "white", "red"),
        border = c("black", "darkblue", "black"),
        lwd = 1.5,
        names = c("N(0,1)", "(N(0,1))^2-1", "(N(0,1))^3"),
        main = "Boxplots of different distributions")
par(bg = "white") # Reset background color

# 5.4. QQ-plots
print("Generating QQ-plots.")
z_desc_2 <- rnorm(200, mean = 4, sd = 5)

# dev.new()
par(mfrow = c(2, 2), bg = "lightcyan") # 2x2 plot layout

qqplot(x_desc, y_desc, pch = 21, bg = "red", main = "QQ-plot x vs y")
qqplot(x_desc, z_desc_2, pch = 21, bg = "red", main = "QQ-plot x vs z_desc_2")

qqnorm(y_desc, pch = 21, bg = "orange", main = "QQ-norm y")
qqline(y_desc, col = "blue", lwd = 2)

qqnorm(z_desc_2, pch = 21, bg = "orange", main = "QQ-norm z_desc_2")
qqline(z_desc_2, col = "blue", lwd = 2)

par(mfrow = c(1, 1), bg = "white") # Reset plot layout

# --- Section 6: Reading Data ---

# The PDF used read.table("Air Quality.data").
# We will use the built-in "airquality" dataset, which is similar.
data(airquality)
Donnees <- airquality

print("Summary of 'airquality' data:")
summary(Donnees)

print("Generating histogram for 'Ozone'.")
# dev.new()
hist(Donnees$Ozone, col = "gold", main = "Histogram of Ozone")

# Using attach/detach
attach(Donnees)
# 'Ozone' is now directly accessible
hist(Ozone, freq = FALSE, col = "gold", main = "Histogram of Ozone (attached)")
detach(Donnees)
