# Project 02: Titanic Survival Prediction

This project uses **Logistic Regression** to solve the classic Titanic classification problem. It predicts whether a passenger survived based on socio-economic status, gender, age, and fare.

## Overview
* **Algorithm**: Logistic Regression (Classification).
* **Features**: P-Class (1st/2nd/3rd), Sex (Encoded), Age, Fare.
* **Target**: Survived (0 = No, 1 = Yes).
* **Preprocessing**: Maps categorical data ('male'/'female') to numeric values (0/1) for model compatibility.

## Files
* `titanic.ipynb` — The complete workflow: data loading, preprocessing, training, and testing.
* `titanic_clean.csv` — A cleaned version of the Titanic dataset ready for training.

## Prediction Example
The notebook tests the model with two famous test cases:
* **Jack**: 3rd Class, Male, 20 years old, Low Fare -> **Prediction: 0 (Did not survive)**
* **Rose**: 1st Class, Female, 17 years old, High Fare -> **Prediction: 1 (Survived)**