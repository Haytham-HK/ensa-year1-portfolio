-- --- TP.03: 04 - DELETE Data (Testing Constraints) ---

SET search_path TO shop, public;

-- 1. This DELETE will fail (due to ON DELETE RESTRICT)
DELETE FROM shop.produits
WHERE nom_produit = 'Souris';

-- 2. This DELETE will succeed (and CASCADE to ligne_commandes)
DELETE FROM shop.commandes WHERE id_commande = 1;

-- 3. This DELETE will now succeed (since the order line is gone)
DELETE FROM shop.produits WHERE nom_produit = 'Souris';
