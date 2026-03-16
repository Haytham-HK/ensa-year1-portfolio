from lattice_optimizer import LatticeOptimizer
from fpylll import IntegerMatrix, LLL, BKZ
import time
import sys

def main():
    print("==================================================")
    print("   AI-DRIVEN LATTICE OPTIMIZATION TOOL (ALOT)    ")
    print("==================================================")
    print("A project by Haytham Kennouz & Elazzouzi Abdelhak")
    print("--------------------------------------------------")
    
    try:
        optimizer = LatticeOptimizer()
    except Exception as e:
        print(f"Error: Could not load AI models. Run 'model_trainer.py' first.")
        return

    print("\n[+] Enter lattice parameters:")
    try:
        dim = int(input("Dimension (e.g., 50): "))
        bits = int(input("Bit-size (e.g., 30): "))
        target_time = float(input("Max allowable time (seconds, e.g., 0.1): "))
    except ValueError:
        print("Invalid input. Please enter numerical values.")
        return

    print("\n[+] AI is analyzing the best strategy...")
    best_strategy = optimizer.recommend_strategy(dim, bits, target_max_time=target_time)
    
    print(f"\n[+] Recommended Strategy:")
    print(f"    Algorithm: {best_strategy['algo']}")
    print(f"    Parameter: {best_strategy['param']}")
    print(f"    Expected Runtime: {best_strategy['pred_runtime']:.4f}s")
    print(f"    Expected Norm:    {best_strategy['pred_norm']:.0f}")

    choice = input("\n[?] Execute this reduction on a live lattice? (y/n): ")
    if choice.lower() == 'y':
        print("\n[+] Generating lattice...")
        A = IntegerMatrix.random(dim, "uniform", bits=bits)
        orig_norm = A[0].norm()
        print(f"    Original shortest vector norm: {orig_norm}")
        
        print(f"[+] Running {best_strategy['algo']} reduction...")
        start_time = time.time()
        if best_strategy['algo'] == 'LLL':
            LLL.reduction(A, delta=best_strategy['param'])
        else:
            BKZ.reduction(A, BKZ.Param(block_size=int(best_strategy['param'])))
        end_time = time.time()
        
        actual_norm = A[0].norm()
        actual_time = end_time - start_time
        
        print("\n[+] Results:")
        print(f"    Actual Runtime: {actual_time:.4f}s (Diff: {actual_time - best_strategy['pred_runtime']:.4f}s)")
        print(f"    Actual Norm:    {actual_norm:.0f} (Diff: {actual_norm - best_strategy['pred_norm']:.0f})")
        print(f"    Improvement:    {(1 - actual_norm/orig_norm)*100:.2f}% reduction in vector length")

if __name__ == "__main__":
    main()
