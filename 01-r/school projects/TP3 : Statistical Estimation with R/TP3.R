# --- TP2: Statistical Estimation with R ---

# PART 1: POINT ESTIMATION


# 1. Create a sample dataset (e.g., Lifespan of electronic components in hours)

sample_data <- c(1020, 980, 1010, 1050, 990, 1005, 1030, 985, 1015, 1000)
n <- length(sample_data)

print("Sample Data:")
print(sample_data)

# 2. Calculate Point Estimators
mean_est <- mean(sample_data)      
var_est <- var(sample_data)        
sd_est <- sd(sample_data)          

cat("Estimated Mean (x_bar):", mean_est, "\n")
cat("Estimated Variance (s^2):", var_est, "\n")
cat("Estimated Standard Deviation (s):", sd_est, "\n")


# PART 2: CONFIDENCE INTERVAL (MEAN)


# 1. Define parameters

confidence_level <- 0.95
alpha <- 1 - confidence_level
z_crit <- qnorm(1 - alpha/2) 

# 2. Calculate Margin of Error
margin_error <- z_crit * (sd_est / sqrt(n))

# 3. Calculate Bounds
lower_bound <- mean_est - margin_error
upper_bound <- mean_est + margin_error

cat("Confidence Level:", confidence_level * 100, "%\n")
cat("Critical Z-value:", round(z_crit, 2), "\n")
cat("Margin of Error:", round(margin_error, 2), "\n")
cat("95% CI for Mean: [", round(lower_bound, 2), ";", round(upper_bound, 2), "]\n")


# PART 3: CONFIDENCE INTERVAL (PROPORTION)

print("\n--- PART 3: Confidence Interval for Proportion ---")

# 1. Sample Data
n_prop <- 200       
x_success <- 120    
p_hat <- x_success / n_prop  

cat("Sample Size (n):", n_prop, "\n")
cat("Estimated Proportion (p_hat):", p_hat, "\n")

# 2. Calculate CI (95%)
standard_error_p <- sqrt((p_hat * (1 - p_hat)) / n_prop)
margin_error_p <- z_crit * standard_error_p

ic_lower <- p_hat - margin_error_p
ic_upper <- p_hat + margin_error_p

cat("95% CI for Proportion: [", round(ic_lower, 4), ";", round(ic_upper, 4), "]\n")
cat("In Percentage: [", round(ic_lower*100, 2), "%;", round(ic_upper*100, 2), "%]\n")



# PART 4: SAMPLE SIZE CALCULATION

marge_desir <- 0.02  
p_estime <- 0.5      
n_necessaire <- ceiling((z_crit^2 * p_estime * (1 - p_estime)) / marge_desir^2)

cat("Desired Margin of Error:", marge_desir * 100, "%\n")
cat("Estimated Proportion used:", p_estime, "\n")