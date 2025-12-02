-- --- TP.03: 03 - UPDATE Data ---

SET search_path TO shop, public;

-- Update product prices
UPDATE shop.produits
SET prix = ROUND(prix * 1.10, 2)
WHERE nom_produit IN ('Souris', 'Clavier');

-- Deactivate out-of-stock products
UPDATE shop.produits
SET actif = FALSE
WHERE stock = 0;

-- Update order status
UPDATE shop.commandes
SET etat = 'PAYEE'
WHERE id_commande = 1;
