# TP02 — Statistical Estimation with R

Moving beyond simple data description, this lab focuses on **Inferential Statistics**. We use R to estimate unknown population parameters based on sample data, which is the core of most real-world data science work.

## Project Overview

The script `tp2_statistical_estimation.R` walks through four practical estimation scenarios:

1.  **Point Estimation**: We take a raw dataset (lifespans of electronic components) and calculate the specific mean ($\bar{x}$) and variance ($s^2$). This is our single "best guess" of the truth.
2.  **Confidence Intervals (Mean)**: Since a single number is rarely perfect, we calculate a range (a 95% Confidence Interval) where the true population mean likely sits, using the standard Z-score method.
3.  **Proportions**: We simulate a customer satisfaction survey to find the confidence interval for a qualitative metric (e.g., "60% ± 5% of users are satisfied").
4.  **Sample Size Planning**: A crucial step in project design—calculating exactly how many data points ($n$) we need to collect to guarantee a specific margin of error (e.g., 2%).

## How to Run

Open `tp2_statistical_estimation.R` in RStudio. I recommend running the code block-by-block:

1.  **Run Part 1** to see the raw estimators printed to the console.
2.  **Run Part 2 & 3** to generate the confidence intervals. Pay attention to the "Margin of Error" output—this tells you the precision of your estimate.
3.  **Run Part 4** to see how the required sample size changes based on your desired precision.