import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error

# 2- Importer la dataset Salary_Data
dataset = pd.read_csv("Salary_Data.csv")

# 3- Spécifier X et y
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

# 4- Diviser le dataset (Training/Test)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

# 5- Construire le modèle
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# 6- Prédiction de X_test
y_pred = regressor.predict(X_test)

# 7- Prédire le salaire pour 15 ans d’expérience
salaire_15 = regressor.predict([[15]])
print(f"Salaire pour 15 ans d'expérience : {salaire_15[0]:.2}")

# 8 & 9- Visualisation
plt.scatter(X_test, y_test, color="red", label="Données Réelles")
plt.plot(X_train, regressor.predict(X_train), color="blue", label="Modèle")
plt.title("Salaire vs Expérience")
plt.xlabel("Années d'expérience")
plt.ylabel("Salaire")
plt.legend()
plt.show()

# 11- Paramètres de l’équation y=ax+b
print(f"Coefficient (a) : {regressor.coef_[0]:.2f}")
print(f"Intercept (b)   : {regressor.intercept_:.2f}")

# 12- Évaluation
print(f"R2 score : {r2_score(y_test, y_pred):.4f}")
print(f"RMSE     : {np.sqrt(mean_squared_error(y_test, y_pred)):.2f}")

# 13- Min et Max de y
print(f"Min y : {y.min()}, Max y : {y.max()}")
