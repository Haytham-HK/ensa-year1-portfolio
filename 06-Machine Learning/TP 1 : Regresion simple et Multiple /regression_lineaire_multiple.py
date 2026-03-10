import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.metrics import r2_score
from sklearn.feature_selection import RFE

# 2- Importer la dataset 50_Startups
dataset = pd.read_csv('50_Startups.csv')

# 3- Spécifier X et y
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

# 4- Gérer les variables catégoriques (State à l'index 3)
ct = ColumnTransformer(transformers=[('encoder', OneHotEncoder(), [3])], remainder='passthrough')
X = np.array(ct.fit_transform(X))

# 5- Diviser le dataset (Training/Test)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

# 6- Construire le modèle
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# 7- Faire la prédicition de y_pred
y_pred = regressor.predict(X_test)

# 8- Faire la prediction sur np.array([[1,0,0, 130000, 140000, 300000]])
pred_specifique = regressor.predict(np.array([[1, 0, 0, 130000, 140000, 300000]]))
print(f"Prédiction spécifique : {pred_specifique[0]:.2f}")

# 9- Donner les valeurs de l’intercept et le coef
print(f"Intercept : {regressor.intercept_:.2f}")
print(f"Coefficients : {regressor.coef_}")

# 10- Calculer le r2 score 
print(f"R2 score (Modèle complet) : {r2_score(y_test, y_pred):.4f}")

# 11- Trouver un modèle avec moins de variables en utilisant RFE
rfe = RFE(estimator=LinearRegression(), n_features_to_select=3)
X_train_rfe = rfe.fit_transform(X_train, y_train)
X_test_rfe = rfe.transform(X_test)

regressor_rfe = LinearRegression()
regressor_rfe.fit(X_train_rfe, y_train)
y_pred_rfe = regressor_rfe.predict(X_test_rfe)

print(f"R2 score (RFE avec 3 variables) : {r2_score(y_test, y_pred_rfe):.4f}")
print(f"Variables sélectionnées par RFE : {rfe.support_}")
