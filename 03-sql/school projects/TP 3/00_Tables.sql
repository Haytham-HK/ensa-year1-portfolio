-- --- TP.03: 00 - Prerequisite Tables ---

CREATE SCHEMA IF NOT EXISTS shop;
SET search_path TO shop, public;

CREATE TABLE IF NOT EXISTS clients (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    ville VARCHAR(60),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS produits (
    id_produit SERIAL PRIMARY KEY,
    nom_produit VARCHAR(120) NOT NULL,
    prix NUMERIC(10, 2) NOT NULL CHECK (prix >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    actif BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS commandes (
    id_commande SERIAL PRIMARY KEY,
    id_client INT NOT NULL REFERENCES clients(id_client) ON DELETE RESTRICT ON UPDATE CASCADE,
    date_commande DATE DEFAULT CURRENT_DATE,
    etat VARCHAR(20) DEFAULT 'NOUVELLE'
);

CREATE TABLE IF NOT EXISTS ligne_commandes (
    id_ligne SERIAL PRIMARY KEY,
    id_commande INT NOT NULL REFERENCES commandes(id_commande) ON DELETE CASCADE,
    id_produit INT NOT NULL REFERENCES produits(id_produit) ON DELETE RESTRICT,
    quantite INT NOT NULL CHECK (quantite > 0),
    prix_unitaire NUMERIC(10, 2) NOT NULL CHECK (prix_unitaire >= 0)
);
