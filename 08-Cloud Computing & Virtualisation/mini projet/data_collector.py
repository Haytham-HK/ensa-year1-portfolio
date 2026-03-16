from fpylll import IntegerMatrix, LLL, BKZ
import random
import time
import pandas as pd
from tqdm import tqdm
import os

def generate_lattice(dim, bits=30):
    """Generates a random lattice of specified dimension."""
    A = IntegerMatrix.random(dim, "uniform", bits=bits)
    return A

def get_hadamard_ratio(A):
    """Calculates the Hadamard ratio as a quality metric."""
    dim = A.nrows
    det_squared = 0
    # For simplicity, we use the product of norms. Hadamard ratio = det(L) / product(norms)
    # Since det(L) is constant, we can just use 1/product(norms) as a relative metric 
    # OR we use the fpylll internal functions for precise metrics.
    # Actually fpylll's GSO can give us the diagonal values (r_i,i)
    return None # We will use root Hermite factor instead as it's more standard.

def collect_data(num_samples=100, output_file="lattice_data.csv"):
    data = []
    
    # Dimensions to explore
    dims = list(range(30, 61, 5)) 
    
    for _ in tqdm(range(num_samples), desc="Collecting Data"):
        dim = random.choice(dims)
        bits = random.randint(20, 40)
        
        # 1. Generate lattice
        A_orig = generate_lattice(dim, bits)
        
        # 2. Try LLL with different delta
        for delta in [0.75, 0.90, 0.99]:
            A = IntegerMatrix(A_orig)
            start_time = time.time()
            LLL.reduction(A, delta=delta)
            end_time = time.time()
            
            # Record metrics
            data.append({
                "dim": dim,
                "bits": bits,
                "algo": "LLL",
                "param": delta,
                "runtime": end_time - start_time,
                "final_norm": A[0].norm() # Length of the shortest vector found
            })
            
        # 3. Try BKZ with different block sizes
        for block_size in [2, 10, 20]:
            A = IntegerMatrix(A_orig)
            # Standard BKZ
            start_time = time.time()
            BKZ.reduction(A, BKZ.Param(block_size=block_size))
            end_time = time.time()
            
            data.append({
                "dim": dim,
                "bits": bits,
                "algo": "BKZ",
                "param": block_size,
                "runtime": end_time - start_time,
                "final_norm": A[0].norm()
            })

    df = pd.DataFrame(data)
    df.to_csv(output_file, index=False)
    print(f"Data saved to {output_file}")

if __name__ == "__main__":
    collect_data(num_samples=50) # Small sample for testing
