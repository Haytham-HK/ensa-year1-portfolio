-- 02_create_tables.sql


-- Table: clients

CREATE TABLE shop.clients (
  id_client SERIAL PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  email VARCHAR(120) UNIQUE,
  telephone VARCHAR(20),
  ville VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Table: produits

CREATE TABLE shop.produits (
  id_produit SERIAL PRIMARY KEY,
  nom_produit VARCHAR(120) NOT NULL,
  prix NUMERIC(10,2) NOT NULL CHECK (prix >= 0),
  stock INT NOT NULL CHECK (stock >= 0),
  actif BOOLEAN DEFAULT TRUE
);

-- Table: commandes

CREATE TABLE shop.commandes (
  id_commande SERIAL PRIMARY KEY,
  id_client INT NOT NULL,
  date_commande DATE DEFAULT CURRENT_DATE,
  etat VARCHAR(20) DEFAULT 'NOUVELLE',
  CONSTRAINT fk_cmd_client FOREIGN KEY (id_client)
    REFERENCES shop.clients(id_client)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- Table: ligne_commandes

CREATE TABLE shop.ligne_commandes (
  id_ligne SERIAL PRIMARY KEY,
  id_commande INT NOT NULL,
  id_produit INT NOT NULL,
  quantite INT NOT NULL CHECK (quantite > 0),
  prix_unitaire NUMERIC(10,2) NOT NULL CHECK (prix_unitaire >= 0),
  CONSTRAINT fk_lc_commande FOREIGN KEY (id_commande)
    REFERENCES shop.commandes(id_commande)
    ON DELETE CASCADE,
  CONSTRAINT fk_lc_produit FOREIGN KEY (id_produit)
    REFERENCES shop.produits(id_produit)
    ON DELETE RESTRICT
);

-- Table: factures

CREATE TABLE shop.factures (
  id_facture SERIAL PRIMARY KEY,
  id_commande INT NOT NULL,
  montant_total NUMERIC(12,2) NOT NULL CHECK (montant_total >= 0),
  date_facture TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_fact_cmd FOREIGN KEY (id_commande)
    REFERENCES shop.commandes(id_commande)
    ON DELETE CASCADE
);

-- Table: paiements

CREATE TABLE shop.paiements (
  id_paiement SERIAL PRIMARY KEY,
  id_facture INT NOT NULL,
  montant NUMERIC(12,2) NOT NULL CHECK (montant > 0),
  mode VARCHAR(20) NOT NULL,
  date_paiement TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_pay_fact FOREIGN KEY (id_facture)
    REFERENCES shop.factures(id_facture)
    ON DELETE RESTRICT
);
