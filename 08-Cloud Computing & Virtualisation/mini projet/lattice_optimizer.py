import joblib
import pandas as pd
import numpy as np
from fpylll import IntegerMatrix, LLL, BKZ
import time

class LatticeOptimizer:
    def __init__(self, runtime_model_path='runtime_model.pkl', norm_model_path='norm_model.pkl'):
        self.runtime_model = joblib.load(runtime_model_path)
        self.norm_model = joblib.load(norm_model_path)
        
    def predict_performance(self, dim, bits, algo, param):
        algo_encoded = 0 if algo == 'LLL' else 1
        X = pd.DataFrame([[dim, bits, algo_encoded, param]], columns=['dim', 'bits', 'algo_encoded', 'param'])
        
        runtime = self.runtime_model.predict(X)[0]
        norm = self.norm_model.predict(X)[0]
        
        return runtime, norm

    def recommend_strategy(self, dim, bits, target_max_time=None, target_min_norm=None):
        strategies = []
        
        # Test LLL
        for delta in [0.75, 0.85, 0.95, 0.99]:
            r, n = self.predict_performance(dim, bits, 'LLL', delta)
            strategies.append({'algo': 'LLL', 'param': delta, 'pred_runtime': r, 'pred_norm': n})
            
        # Test BKZ
        for beta in range(2, 41, 5):
            r, n = self.predict_performance(dim, bits, 'BKZ', beta)
            strategies.append({'algo': 'BKZ', 'param': beta, 'pred_runtime': r, 'pred_norm': n})
            
        # Ranking
        if target_max_time:
            # Filter by time, then pick best norm
            valid = [s for s in strategies if s['pred_runtime'] <= target_max_time]
            if not valid: return min(strategies, key=lambda x: x['pred_runtime'])
            return min(valid, key=lambda x: x['pred_norm'])
        
        # Default: best norm / runtime ratio (heuristic)
        # We use log(norm) because norms are huge
        return min(strategies, key=lambda x: x['pred_norm'])

def demo():
    optimizer = LatticeOptimizer()
    
    dim = 50
    bits = 30
    print(f"--- Lattice Optimization for Dim={dim}, Bits={bits} ---")
    
    # Example 1: Fastest reduction
    best_fast = optimizer.recommend_strategy(dim, bits, target_max_time=0.01)
    print(f"\nRecommended for fast reduction (time < 0.01s):")
    print(f"Algo: {best_fast['algo']}, Param: {best_fast['param']}")
    print(f"Predicted Runtime: {best_fast['pred_runtime']:.4f}s, Predicted Norm: {best_fast['pred_norm']:.0f}")

    # Example 2: Best quality
    best_quality = optimizer.recommend_strategy(dim, bits)
    print(f"\nRecommended for best quality:")
    print(f"Algo: {best_quality['algo']}, Param: {best_quality['param']}")
    print(f"Predicted Runtime: {best_quality['pred_runtime']:.4f}s, Predicted Norm: {best_quality['pred_norm']:.0f}")

if __name__ == "__main__":
    demo()
