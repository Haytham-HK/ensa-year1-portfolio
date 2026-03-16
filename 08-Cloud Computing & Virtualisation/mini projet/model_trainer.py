import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, r2_score
import joblib
import matplotlib.pyplot as plt
import os

def train_models(data_file="lattice_data.csv"):
    df = pd.DataFrame(pd.read_csv(data_file))
    
    # 1. Preprocessing
    # algo: LLL=0, BKZ=1
    df['algo_encoded'] = df['algo'].map({'LLL': 0, 'BKZ': 1})
    
    X = df[['dim', 'bits', 'algo_encoded', 'param']]
    y_runtime = df['runtime']
    y_norm = df['final_norm']
    
    # Split the data
    X_train, X_test, y_runtime_train, y_runtime_test = train_test_split(X, y_runtime, test_size=0.2, random_state=42)
    _, _, y_norm_train, y_norm_test = train_test_split(X, y_norm, test_size=0.2, random_state=42)
    
    # 2. Train Runtime Model
    print("Training Runtime Predictor...")
    runtime_model = RandomForestRegressor(n_estimators=100, random_state=42)
    runtime_model.fit(X_train, y_runtime_train)
    
    runtime_pred = runtime_model.predict(X_test)
    print(f"Runtime - MAE: {mean_absolute_error(y_runtime_test, runtime_pred):.4f}")
    print(f"Runtime - R2: {r2_score(y_runtime_test, runtime_pred):.4f}")
    
    # 3. Train Quality (Norm) Predictor
    print("\nTraining Quality (Norm) Predictor...")
    norm_model = RandomForestRegressor(n_estimators=100, random_state=42)
    norm_model.fit(X_train, y_norm_train)
    
    norm_pred = norm_model.predict(X_test)
    print(f"Norm - MAE: {mean_absolute_error(y_norm_test, norm_pred):.4f}")
    print(f"Norm - R2: {r2_score(y_norm_test, norm_pred):.4f}")
    
    # 4. Save the models
    joblib.dump(runtime_model, 'runtime_model.pkl')
    joblib.dump(norm_model, 'norm_model.pkl')
    print("\nModels saved to 'runtime_model.pkl' and 'norm_model.pkl'")
    
    # 5. Visualize (optional)
    plt.figure(figsize=(10, 5))
    plt.subplot(1, 2, 1)
    plt.scatter(y_runtime_test, runtime_pred, alpha=0.5)
    plt.plot([y_runtime_test.min(), y_runtime_test.max()], [y_runtime_test.min(), y_runtime_test.max()], 'r--')
    plt.xlabel('True Runtime')
    plt.ylabel('Predicted Runtime')
    plt.title('Runtime Prediction Performance')
    
    plt.subplot(1, 2, 2)
    plt.scatter(y_norm_test, norm_pred, alpha=0.5)
    plt.plot([y_norm_test.min(), y_norm_test.max()], [y_norm_test.min(), y_norm_test.max()], 'g--')
    plt.xlabel('True Final Norm')
    plt.ylabel('Predicted Final Norm')
    plt.title('Norm Prediction Performance')
    
    plt.tight_layout()
    os.makedirs('docs', exist_ok=True)
    plt.savefig('docs/model_performance.png')
    print("Performance plot saved to 'docs/model_performance.png'")

if __name__ == "__main__":
    train_models()
