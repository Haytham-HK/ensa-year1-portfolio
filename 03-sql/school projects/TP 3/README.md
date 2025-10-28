# TP03 — DML: Data Manipulation (PostgreSQL)

This lab demonstrates common DML (INSERT, UPDATE, DELETE) operations for the e-commerce model. It focuses on handling data, dependencies, and the behavior of database constraints.

## Prerequisites
- PostgreSQL installed and running.
- The database (`tp_ecommerce`) and schema (`shop`) must be created (e.g., from `TP 2`).

## Files
- `00_schema.sql` — (Re)creates the required tables (`clients`, `produits`, `commandes`, `ligne_commandes`).
- `01_insert.sql` — Inserts all initial data and demonstrates an `ON CONFLICT` (UPSERT) operation.
- `03_update.sql` — Runs various `UPDATE` commands to modify prices and statuses.
- `04_delete.sql` — Demonstrates `DELETE` and the effects of `RESTRICT` vs. `CASCADE` constraints.
- `05_errors.sql` — Intentionally fails with `CHECK` constraint violations (e.g., negative price).

