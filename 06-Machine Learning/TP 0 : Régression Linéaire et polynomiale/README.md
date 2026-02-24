## TP0: Linear and Polynomial Regression with NumPy

This practical exercise introduces the basics of machine learning by implementing Linear and Polynomial Regression from scratch using only **NumPy** (no scikit-learn).

### What We Did

#### 1. Linear Regression

- Generated a synthetic dataset using `make_regression` with added noise
- Built a linear model: **y = θ₀ + θ₁x**
- Implemented the **Mean Squared Error (MSE)** as our cost function
- Implemented **Gradient Descent** to optimize the model parameters
- Evaluated the model using the **R² coefficient of determination**

#### 2. Polynomial Regression

- Modified the dataset to make it non-linear by adding `abs(y/2)` to create a quadratic relationship
- Created polynomial features (x²) to capture non-linear patterns
- Applied the same gradient descent approach with additional features

### Key Concepts Learned

- **Gradient Descent**: An optimization algorithm used to minimize the cost function
- **Bias Term**: Adding a column of ones to enable the model to learn the intercept
- **Feature Engineering**: Creating new features (like x²) to handle non-linear data
- **Model Evaluation**: Using R² to measure how well the model explains the variance in the data

### Technologies Used

- **Python 3**
- **NumPy** - For numerical computations
- **Matplotlib** - For data visualization
- **scikit-learn** - For generating synthetic datasets

---


**Student:** Haytham KENNOUZ