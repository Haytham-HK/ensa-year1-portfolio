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
y_mat <- matrix(1:12, nrow = 3, byrow = TRUE) # nrow :row number
print("Matrix created with matrix() (byrow=TRUE):") #If byrow false (default) matrix filled by columns wich means first line is (1,4,7,10)
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

x_plot <- runif(50, 0, 2) #50 is number of numbers generated , numbers are between 0 and 2
y_plot <- runif(50, 0, 2)

print("Generating a basic plot.")
plot(x_plot, y_plot,
     main = "Graph Title",
     xlab = "X-axis label",
     ylab = "Y-axis label",
     col = "darkred", #color of points
     pch = 19) # symbol of the points

# Add lines and text
abline(h = .6, v = .6, col = "blue", lty = 2) # lty for the line type (dashed - solid - doted ...)
text(.6, .6, "Intersection (0.6, 0.6)", pos = 4) # pos=4 for text to the right of the (x,y) coordinate

# --- Section 4: Random Simulation ---


print("10 samples from N(0,1):")
print(rnorm(10))


print("10 samples from Binomial(size=20, prob=0.5):")
print(rbinom(10, size = 20, prob = .5))
# This line: Run 10 experiments (n=10). Each experiment is 20 trials (size=20)
# with a 50% chance of success (prob=0.5).
# It's like flipping a coin 20 times and counting heads, then repeating that 10 times and outputting how much you heads you got .

print("10 samples from Cauchy distribution:")
print(rcauchy(10))

print("10 samples from Uniform(min=0, max=1):")
print(runif(10, min = 0, max = 1))
#same chance of getting any number .

print("Sample without replacement (5 from 1:40):")
print(sample(1:40, 5))
#It takes a random sample of 5 numbers from the sequence of numbers 1 to 40.
#without replacement if it draws a number it does not get taken again .

print("Sample with replacement (10 from 1:10):")
print(sample(1:10, 10, replace = TRUE))
#same thing but number can be taken twice

print("Weighted probability sample:")
print(sample(c("failure", "success"), 10, replace = TRUE, prob = c(0.7, 0.3)))
# Picks "failure" or "success" 10 times, with a 70% chance for "failure".

# --- Section 5: Empirical Descriptions ---


x_desc <- rnorm(100)
# Get 100 random numbers. The "rnorm" command creates a "bell curve" pattern,
# meaning most numbers will be close to the average (in the middle),
# and very few will be extremely high or lo

n <- length(x_desc)

# 5.1. Empirical distribution function
print("Generating empirical distribution plot.")
# dev.new()
plot(sort(x_desc), 1:n / n,
     type = "s", # it like drawing steps between points
     ylim = c(0, 1), #the y-axis start at 0 (the bottom) and end at 1 (the top).
     xlab = "x",
     ylab = "Fn(x)",
     main = "Empirical vs. Theoretical Distribution")

curve(pnorm(x, 0, 1), add = TRUE, col = "blue", lwd = 2)
# Add the "perfect" theoretical S-curve (pnorm) on top of the current plot.
# 'add=TRUE' is key: it tells R to add to the plot, not create a new one.
# 'lwd=2' makes the blue line twice as thick

legend("bottomright", legend = c("Empirical (Fn)", "Theoretical (pnorm)"),
       col = c("black", "blue"), lty = 1, lwd = c(1, 2))
# Add a legend (a key) to the "bottomright" corner to explain the lines.
# It matches the text labels to the line colors (col) and widths (lwd) .

# 5.2. Histogram
print("Generating histogram with density curve.")

hist(x_desc, breaks = 20, freq = FALSE, col = "cyan",
     main = "Histogram and Theoretical N(0,1) Density")
# Create a histogram (bar chart) of our random 'x_desc' data.
# 'breaks = 20': Tries to create 20 bins (bars) for the data.
# 'freq = FALSE': Y-axis shows density (probability) instead of raw count.
# 'col = "cyan"': Makes the bars cyan color.
# 'main = "..."': Sets the main title for the plot. 

curve(dnorm(x), add = TRUE, col = "darkblue", lwd = 2)
# Add the "perfect" theoretical bell curve shape (dnorm) on top of the histogram.
# 'add=TRUE' draws it on the same plot.
# We can do this because the histogram's y-axis is density (freq=FALSE)

# 5.3. Boxplot
print("Generating comparative boxplots.")

# y_desc: Get 400 bell-curve numbers, square them, and subtract 1.
y_desc <- (rnorm(400))^2 - 1
# z_desc: Get 50 bell-curve numbers and cube them.
z_desc <- rnorm(50)^3



par(bg = "lightcyan") # Change background 

boxplot(x_desc, y_desc, z_desc,
        col = c("blue", "white", "red"),
        border = c("black", "darkblue", "black"),
        lwd = 1.5,
        names = c("N(0,1)", "(N(0,1))^2-1", "(N(0,1))^3"),
        main = "Boxplots of different distributions")
# Create a side-by-side boxplot to compare our three datasets.
# 'col=' sets the fill color for each box.
# 'border=' sets the outline color for each box.
# 'lwd=1.5' makes the lines slightly thicker.
# 'names=' provides custom labels for the x-axis for each box.
# 'main=' sets the main title of the plot.

par(bg = "white") # Reset background color

# 5.4. QQ-plots
print("Generating QQ-plots.")

# Create another bell-curve dataset, but this time centered at 4 (mean=4)
# and with a wider spread (standard deviation sd=5).
z_desc_2 <- rnorm(200, mean = 4, sd = 5)

# Set graphical parameters: arrange the next plots in a 2x2 grid (mfrow)
# and set the background (bg) to "lightcyan".
par(mfrow = c(2, 2), bg = "lightcyan") 

# Plot 1 (in grid slot 1): Compares normal 'x_desc' to skewed 'y_desc'.
# This will be CURVED, as the shapes don't match.
qqplot(x_desc, y_desc, pch = 21, bg = "red", main = "QQ-plot x vs y")
# Plot 2 (in grid slot 2): Compares normal 'x_desc' to normal 'z_desc_2'.
# This will be a STRAIGHT LINE, as both are bell curves
qqplot(x_desc, z_desc_2, pch = 21, bg = "red", main = "QQ-plot x vs z_desc_2")

# Plot 3 (in grid slot 3): Makes a plot to check if 'y_desc' is a bell curve.
# 'qqnorm' plots our data as orange dots.
qqnorm(y_desc, pch = 21, bg = "orange", main = "QQ-norm y")
# 'qqline' adds the straight blue line where the dots *should* be.
# Since 'y_desc' is not a bell curve, the dots will curve away from this line.
qqline(y_desc, col = "blue", lwd = 2)

# Plot 4 (in grid slot 4): Now check 'z_desc_2', which *is* a bell curve.
# 'qqnorm' plots our data as orange dots.
qqnorm(z_desc_2, pch = 21, bg = "orange", main = "QQ-norm z_desc_2")
# 'qqline' adds the straight blue line where the dots should be.
# Since 'z_desc_2' IS a bell curve, the dots will follow this line closely.
qqline(z_desc_2, col = "blue", lwd = 2)

par(mfrow = c(1, 1), bg = "white") # Reset plot layout

# --- Section 6: Reading Data ---


data(airquality)
Donnees <- airquality

print("Summary of 'airquality' data:")
summary(Donnees)

print("Generating histogram for 'Ozone'.")
# Make a histogram (bar chart) using just the 'Ozone' column from our data.
# 'Donnees$Ozone' selects that specific column.
hist(Donnees$Ozone, col = "gold", main = "Histogram of Ozone")

# Using attach/detach
attach(Donnees)
# 'Ozone' is now directly accessible
hist(Ozone, freq = FALSE, col = "gold", main = "Histogram of Ozone (attached)")
detach(Donnees)
