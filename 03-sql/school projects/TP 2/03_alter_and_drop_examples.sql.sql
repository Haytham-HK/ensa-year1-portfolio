-- 03_alter_and_drop_examples.sql


-- 1) Add a column

ALTER TABLE shop.clients
ADD COLUMN adresse TEXT;

-- 2) Modify column type

ALTER TABLE shop.clients
ALTER COLUMN ville TYPE VARCHAR(100);

-- 3) Rename a column

ALTER TABLE shop.commandes
RENAME COLUMN etat TO statut;   

-- 4) Drop a column

ALTER TABLE shop.clients
DROP COLUMN telephone;

-- 5) Droping tables order :

DROP TABLE IF EXISTS shop.paiements;
DROP TABLE IF EXISTS shop.factures;
DROP TABLE IF EXISTS shop.ligne_commandes;
DROP TABLE IF EXISTS shop.commandes;
DROP TABLE IF EXISTS shop.produits;
DROP TABLE IF EXISTS shop.clients;


