# TP04 — PL/SQL: Exception Handling

This lab focuses on robust error handling in Oracle PL/SQL. It demonstrates how to catch predefined system errors (like division by zero) and how to define and raise custom business logic exceptions.

## Project Structure

### 1. Setup
* `table_creation.sql`: Creates and populates the `employees` table used in the examples.

### 2. Predefined Exceptions
* `zero_division.sql`: Demonstrates catching the `ZERO_DIVIDE` error when attempting math operations.
* `no_data.sql`: Handles the `NO_DATA_FOUND` exception when a `SELECT INTO` returns no rows.
* `too_many_rows.sql`: catches the `TOO_MANY_ROWS` exception when a single-row query returns multiple results.

### 3. Custom & Other Exceptions
* `error_catching.sql`: Uses `PRAGMA EXCEPTION_INIT` to map a specific Oracle error code (e.g., -20010) to a named exception.
* `error_catching_2.sql`: Declares a user-defined exception (`ex_low_salary`) and raises it explicitly using `RAISE` based on a business rule.
* `other_errors.sql`: Shows the use of `WHEN OTHERS` to catch any unforeseen errors and log the message using `SQLERRM`.
