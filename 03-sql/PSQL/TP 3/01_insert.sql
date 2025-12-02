-- --- TP.03: 01 - INSERT Data ---

SET search_path TO shop, public;

-- Insert clients
INSERT INTO shop.clients (nom, email, ville)
VALUES ('Ali', 'ali@example.com', 'Rabat');

INSERT INTO shop.clients (nom, email, ville) VALUES
('Sara', 'sara@example.com', 'Casablanca'),
('Youssef', 'youssef@example.com', 'Fès');

-- Insert products
INSERT INTO shop.produits (nom_produit, prix, stock)
VALUES
('PC Portable', 7999.00, 12),
('Souris', 99.00, 100),
('Clavier', 149.00, 60);

-- Create order 
INSERT INTO shop.commandes (id_client)
SELECT id_client FROM shop.clients WHERE email = 'ali@example.com';


INSERT INTO shop.ligne_commandes (id_commande, id_produit, quantite, prix_unitaire)
VALUES
(
    1,
    (SELECT id_produit FROM shop.produits WHERE nom_produit = 'PC Portable'),
    1,
    (SELECT prix FROM shop.produits WHERE nom_produit = 'PC Portable')
),
(
    1,
    (SELECT id_produit FROM shop.produits WHERE nom_produit = 'Souris'),
    2,
    (SELECT prix FROM shop.produits WHERE nom_produit = 'Souris')
);


INSERT INTO shop.clients (nom, email, ville)
VALUES ('Ali Nouveau', 'ali@example.com', 'Tanger')
ON CONFLICT (email) DO UPDATE
SET
    nom = EXCLUDED.nom,
    ville = EXCLUDED.ville;

