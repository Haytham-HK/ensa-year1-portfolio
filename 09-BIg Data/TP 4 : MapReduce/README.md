# TP 4: Big Data - MapReduce with R (rmr2)

This repository contains a series of exercises focused on implementing the **MapReduce** paradigm using the **R** programming language and the **rmr2** library (part of the RHadoop ecosystem).

## Overview
The goal of this practical work (TP) was to understand the fundamental concepts of MapReduce (Map and Reduce functions) and apply them to various data processing tasks, from simple counting to statistical analysis and job chaining.

## Technologies Used
*   **R**: Programming language for statistical computing.
*   **rmr2**: R package for MapReduce integration (RHadoop).
*   **Local Backend**: Exercises are configured to run using `rmr.options(backend = "local")`.

## Project Structure
The project is divided into 6 exercises, each targeting a specific MapReduce pattern:

*   **`exercise_1.R` (Letter Counting)**: Basic introduction to MapReduce for counting character occurrences in a vector.
*   **`exercise_2.R` (Numerical Categorization)**: Classifying numbers (even/odd), calculating sums/means, and grouping values into custom ranges (small/medium/large).
*   **`exercise_3.R` (Data Frame Processing)**: Working with structured data (data.frames) to calculate group-specific metrics like mean, variance, and standard deviation.
*   **`exercise_4.R` (Word Count)**: Implementation of the classic Word Count algorithm on text data, including word length filtering and frequency analysis.
*   **`exercise_5.R` (Distributed Descriptive Statistics)**: Generating advanced statistical summaries (N, Mean, SD, Min, Max, Median) for categorical datasets.
*   **`exercise_6.R` (Job Chaining)**: Demonstrating how to chain multiple MapReduce jobs, where the output of the first job (counting) serves as the input for the second job (finding the maximum).

## How to Run
Ensure you have the `rmr2` library installed in your R environment. You can run each exercise independently:
```r
source("exercise_1.R")
```
