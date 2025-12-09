# --- TD01: Data Analysis - Principal Component Analysis  ---

# EXERCISE 1: MANUAL PCA CALCULATION
# Load the data from the TD
X <- data.frame(
  Y1 = c(4, 6, 8),
  Y2 = c(5, 7, 0)
)
# Name the rows X1, X2, X3
row.names(X) <- c("X1", "X2", "X3")
print("Original Data Matrix (X):")
print(X)

# Q1. Center and Standardize (Centrer et Normer)
# Calculate Mean and SD for each column
means <- colMeans(X)
sds <- apply(X, 2, sd)
# Manual Standardization (Z = (x - mean) / sd)
Z <- scale(X, center = TRUE, scale = TRUE)
print("Standardized Matrix (Z):")
print(Z)

# Q2. Covariance (V) and Correlation (R) Matrices
# Covariance Matrix (V) of the original data
V <- cov(X)
print("Covariance Matrix (V):")
print(V)
# Correlation Matrix (R)
R <- cor(X)
print("Correlation Matrix (R):")
print(R)


# Q4. Diagonalize the Matrix (Eigenvalues/Vectors)
eigen_results <- eigen(R)
# Eigenvalues (Lambda) - Represent the amount of variance explained by each axis
lambda <- eigen_results$values
print("Eigenvalues (Lambda):")
print(lambda)
# Eigenvectors (Fi) - The directions of the new axes
vectors <- eigen_results$vectors
print("Eigenvectors (Fi):")
print(vectors)


# Q5. Percentage of Inertia
total_inertia <- sum(lambda)
inertia_percent <- (lambda / total_inertia) * 100
print("Percentage of Inertia per Axis:")
print(paste0(round(inertia_percent, 2), "%"))


# VERIFICATION WITH BUILT-IN FUNCTION
# scale. = TRUE means we are using the Correlation matrix (Standardized PCA)
pca_res <- prcomp(X, scale. = TRUE)
print("Standard Deviations (sqrt of eigenvalues):")
print(pca_res$sdev)
print("Eigenvalues (sdev^2):")
print(pca_res$sdev^2)
print("Rotation (Eigenvectors):")
print(pca_res$rotation)