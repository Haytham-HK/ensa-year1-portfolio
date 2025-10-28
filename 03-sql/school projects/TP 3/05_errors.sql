-- --- TP.03: 05 - Error Examples (Violating CHECKs) ---

SET search_path TO shop, public;

-- This INSERT will fail (Negative price violates CHECK)
INSERT INTO shop.produits (nom_produit, prix, stock)
VALUES ('USB-C Cable', -10, 10);

-- This INSERT will fail (Invalid quantity violates CHECK)
INSERT INTO shop.ligne_commandes (id_commande, id_produit, quantite, prix_unitaire)
VALUES (999, 1, 0, 10.0);
