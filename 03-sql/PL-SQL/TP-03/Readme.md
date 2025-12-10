# TP04: PL/SQL Cursors

**Institution:** ENSA Beni Mellal (ENSA-BM)
**Course:** Database - PL/SQL

## Overview
This lab (Travaux Pratiques) focuses on mastering Cursors in PL/SQL. The primary goal is to understand the difference between implicit and explicit cursors and how to manipulate them effectively using Oracle Database.

## Environment Setup
The lab runs on an Oracle XE database (Docker).

### Database Initialization
The initialization script (db.sql) creates the necessary DEPT and EMP tables.

**Docker Setup Command:**
```bash
# Copy script to container
docker cp db.sql oracle-xe:/tmp/db.sql

# Enter container
docker exec -it oracle-xe bash

# Connect to SQL*Plus
sqlplus / as sysdba

# Run the script inside SQL*Plus
@/tmp/db.sql
```

## Part 1: Implicit Cursors

### Ex 1.1: Delete all employees in Dept 40. Use SQL%ROWCOUNT to display the number of deleted rows or a "None" message .

### Ex 1.2: Increase Dept 30 salaries by 10%. Log how many rows were updated .

## Part 2: Explicit Cursors (Lifecycle)

### Ex 2.1: create c_emp to fetch ename, sal, deptno. Use manual OPEN, FETCH loop, and CLOSE. Display results .

### Ex 2.2: Add a manual counter variable to Ex 2.1. Compare it against c_emp%ROWCOUNT at the end .

## Part 3: %ROWTYPE

### Ex 3.1: Create c_dep10 for Dept 10 using SELECT Fetch into a %ROWTYPE variable and display details .

### Ex 3.2: Filter Ex 3.1 to show only salaries > 2000. Display a final count of these high earners .

## Part 4: Parameterized Cursors

### Ex 4.1: Create c_emp_dept(p_deptno). Pass 30 as the parameter and display the employees .

### Ex 4.2: Create c_sal_min(p_min). Pass a minimum salary (e.g., 2000). Count matches; if 0 matches, display a specific message .

## Part 5: FOR Loops

### Ex 5.1: Refactor Ex 2.1 using a FOR rec IN (SELECT ...) loop (remove explicit Open/Fetch/Close) .

### Ex 5.2: Loop through all employees. Categorize salaries as LOW (<1500), MEDIUM (1500-3000), or HIGH (>3000) .
