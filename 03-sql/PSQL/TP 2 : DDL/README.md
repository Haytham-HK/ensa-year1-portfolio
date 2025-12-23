# TP02 — DDL: E-commerce model (PostgreSQL)

This lab models a small e-commerce system using DDL (CREATE/ALTER/DROP), constraints (PK, FK, UNIQUE, CHECK) and demonstrates deletion order enforced by foreign keys.  

## Prerequisites
- PostgreSQL installed and running.

## Files
- `01_setup_db_and_schema.sql` — create database `tp_ecommerce`, schema `shop`, and set `search_path`.
- `02_create_tables.sql` — create main tables: `clients`, `produits`, `commandes`, `ligne_commandes`, `factures`, `paiements` with constraints.
- `03_alter_and_drop_examples.sql` — ALTER TABLE examples and DROP order examples.


## How to run
```bash
# 1. Run as superuser to create the database and schema
psql -U postgres -f 01_setup_db_and_schema.sql

# 2. Connect to the new database
psql -U postgres -d tp_ecommerce

# 3. Create all tables
psql -U postgres -d tp_ecommerce -f 02_create_tables.sql

# 4. Run ALTER and DROP examples
psql -U postgres -d tp_ecommerce -f 03_alter_and_drop_examples.sq
