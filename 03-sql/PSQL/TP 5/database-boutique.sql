-- ============================================================================
--  SCHEMA: Boutique (PostgreSQL)
--  Tables : PRODUCT_CATEGORY, PRODUCT, CUSTOMER, PURCHASE_ORDER, ORDER_PRODUCT
-- ============================================================================

-- Optionnel : 
DROP TABLE IF EXISTS order_product CASCADE;
DROP TABLE IF EXISTS purchase_order CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS product_category CASCADE;
DROP TABLE IF EXISTS customer CASCADE;

-- =========================
--        D D L
-- =========================

-- 1) PRODUCT_CATEGORY
CREATE TABLE product_category (
    product_category_id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                 VARCHAR(255) NOT NULL UNIQUE,
    description          VARCHAR(255)
);

-- 2) CUSTOMER
CREATE TABLE customer (
    customer_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    firstname     VARCHAR(50)  NOT NULL,
    lastname      VARCHAR(50)  NOT NULL,
    register_date DATE         NOT NULL DEFAULT CURRENT_DATE,
    birth_date    DATE,
    address       VARCHAR(255),
    zipcode       CHAR(5),
    city          VARCHAR(45),
    phone_number  VARCHAR(20)
);

-- 3) PRODUCT
CREATE TABLE product (
    product_id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_category_id INTEGER NULL REFERENCES product_category(product_category_id)
                         ON UPDATE CASCADE ON DELETE SET NULL,
    name                VARCHAR(255) NOT NULL,
    description         VARCHAR(255),
    price               NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    available_stock     INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT uq_product_name UNIQUE (name)
);

-- 4) PURCHASE_ORDER
CREATE TABLE purchase_order (
    order_id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customer(customer_id)
               ON UPDATE CASCADE ON DELETE RESTRICT,
    date        DATE NOT NULL DEFAULT CURRENT_DATE
);

-- 5) ORDER_PRODUCT 
CREATE TABLE order_product (
    order_id   INTEGER NOT NULL REFERENCES purchase_order(order_id)
               ON UPDATE CASCADE ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES product(product_id)
               ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT pk_order_product PRIMARY KEY (order_id, product_id)
);

-- Index utiles (performances sur les jointures et recherches)
CREATE INDEX idx_product_category_id ON product(product_category_id);
CREATE INDEX idx_purchase_order_customer_id ON purchase_order(customer_id);
CREATE INDEX idx_order_product_product_id ON order_product(product_id);

-- =========================
--        D M L
-- =========================

-- A) Catégories
INSERT INTO product_category (name, description) VALUES
('Fitness',     'Matériel de sport et remise en forme'),
('Automotive',  'Pièces et accessoires automobiles'),
('Electronics', 'Capteurs et modules électroniques'),
('Toys',        'Jeux et jouets');

-- B) Clients
INSERT INTO customer (firstname, lastname, register_date, birth_date, address, zipcode, city, phone_number) VALUES
('Sara',   'Benali',  CURRENT_DATE - INTERVAL '200 days', DATE '2003-05-11', '12 Rue des Oliviers', '40000', 'Marrakesh', '0600000001'),
('Youssef','Ait',     CURRENT_DATE - INTERVAL '150 days', DATE '2002-11-23', '45 Bd Hassan II',    '10000', 'Rabat',      '0600000002'),
('Amine',  'Mouline', CURRENT_DATE - INTERVAL '90 days',  DATE '2001-01-19', '3 Av. Mohammed V',   '20000', 'Casablanca', '0600000003'),
('Fatima', 'Hassan',  CURRENT_DATE - INTERVAL '40 days',  DATE '2004-07-02', '6 Rue Taza',         '30000', 'Fès',        '0600000004'),
('Zahra',  'Omar',    CURRENT_DATE - INTERVAL '10 days',  DATE '2003-09-14', 'Lot Ennakhil',       '50000', 'Agadir',     '0600000005');

-- C) Produits
INSERT INTO product (product_category_id, name, description, price, available_stock) VALUES
((SELECT product_category_id FROM product_category WHERE name = 'Fitness'),
 'ProForm 6.0 RT', 'Tapis de course', 799.00, 5),
((SELECT product_category_id FROM product_category WHERE name = 'Automotive'),
 'Wilwood 260-11179', 'Maître-cylindre de frein', 129.90, 12),
(NULL,
 'HC-SR04', 'Capteur ultrason', 5.50, 200),
((SELECT product_category_id FROM product_category WHERE name = 'Electronics'),
 'ESP32-WROOM', 'Module WiFi/BLE', 8.90, 150),
((SELECT product_category_id FROM product_category WHERE name = 'Electronics'),
 'Raspberry Pi 4', 'Mini-ordinateur 4GB', 79.00, 20),
((SELECT product_category_id FROM product_category WHERE name = 'Toys'),
 'LEGO Technic 42110', 'Land Rover Defender', 199.00, 8),
((SELECT product_category_id FROM product_category WHERE name = 'Fitness'),
 'Kettlebell 16kg', 'Poids de musculation', 35.00, 30),
((SELECT product_category_id FROM product_category WHERE name = 'Automotive'),
 'Bosch Wiper A928S', 'Balais d’essuie-glace', 24.50, 60);

-- D) Commandes
INSERT INTO purchase_order (customer_id, date) VALUES
(1, CURRENT_DATE - INTERVAL '7 days'),
(2, CURRENT_DATE - INTERVAL '3 days'),
(3, CURRENT_DATE - INTERVAL '1 day');

-- E) Orders content (ORDER_PRODUCT)
-- 1st order (client 1)
INSERT INTO order_product (order_id, product_id) VALUES
(1, (SELECT product_id FROM product WHERE name = 'ProForm 6.0 RT')),
(1, (SELECT product_id FROM product WHERE name = 'Kettlebell 16kg'));

-- 2end order (client 2)
INSERT INTO order_product (order_id, product_id) VALUES
(2, (SELECT product_id FROM product WHERE name = 'Wilwood 260-11179')),
(2, (SELECT product_id FROM product WHERE name = 'Bosch Wiper A928S'));

-- 3ed order (client 3)
INSERT INTO order_product (order_id, product_id) VALUES
(3, (SELECT product_id FROM product WHERE name = 'HC-SR04')),
(3, (SELECT product_id FROM product WHERE name = 'ESP32-WROOM'));

-- =========================
--   Verfication commandes
-- =========================

-- products and category 
SELECT p.name AS product_name, c.name AS category_name
FROM product p
LEFT JOIN product_category c ON p.product_category_id = c.product_category_id
ORDER BY p.name;

-- Order details
SELECT o.order_id, o.date, c.firstname || ' ' || c.lastname AS customer_name,
       p.name AS product_name
FROM purchase_order o
JOIN customer c ON c.customer_id = o.customer_id
JOIN order_product op ON op.order_id = o.order_id
JOIN product p ON p.product_id = op.product_id
ORDER BY o.order_id, p.name;

