#TP_5#

#1-Table content verification :
SELECT * FROM product;
SELECT * FROM product_category;
SELECT * FROM customer;
SELECT * FROM purchase_order;
SELECT * FROM order_product;

#2-INNER JOIN :

#2.1-Lists the name of each produit and its category .
SELECT p.name AS product_name, c.name AS category_name
FROM product p
INNER JOIN product_category c ON p.product_category_id =
c.product_category_id;

#2.2-Lists ordered products with the name of client who bought it .
SELECT c.firstname, c.lastname, p.name AS product_name
FROM customer c
JOIN purchase_order o ON c.customer_id = o.customer_id
JOIN order_product op ON o.order_id = op.order_id
JOIN product p ON p.product_id = op.product_id;

#3-LEFT JOIN :

#3.1-Shows all products (also the one with no categorie) .
SELECT p.name AS product_name, c.name AS category_name
FROM product p
LEFT JOIN product_category c ON p.product_category_id =
c.product_category_id;

#3.2-Lists all clients and commands (even the ones with no commande) .
SELECT c.firstname, c.lastname, o.order_id, o.date
FROM customer c
LEFT JOIN purchase_order o ON c.customer_id = o.customer_id
ORDER BY c.lastname;

#4-RIGHT JOIN :

#Lists all categories (even the ones with no products) .
SELECT p.name AS product_name, c.name AS category_name
FROM product p
RIGHT JOIN product_category c ON p.product_category_id =
c.product_category_id
ORDER BY c.name;

#5-FULL JOIN :

#Shows all products and categories (even the ones with no relation) .
SELECT p.name AS product_name, c.name AS category_name
FROM product p
FULL JOIN product_category c ON p.product_category_id =
c.product_category_id;

#6-Jointures multiples :

#Shows all details about commandes .
SELECT
c.firstname || ' ' || c.lastname AS client,
o.date AS order_date,
p.name AS product
FROM purchase_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_product op ON o.order_id = op.order_id
JOIN product p ON p.product_id = op.product_id
ORDER BY o.date DESC;

#7-CROSS JOIN :

#Shows all posible combination between products and categories .
SELECT p.name AS product_name, c.name AS category_name
FROM product p
CROSS JOIN product_category c;

#8-Agrégation et jointure

#Shows number of products per categorie .
SELECT c.name AS category_name, COUNT(p.product_id) AS
total_produits
FROM product_category c
LEFT JOIN product p ON c.product_category_id =
p.product_category_id
GROUP BY c.name
ORDER BY total_produits DESC;

#Shows the total number of products order by each clients .
SELECT c.firstname || ' ' || c.lastname AS client,
COUNT(op.product_id) AS nb_produits_commandes
FROM customer c
LEFT JOIN purchase_order o ON c.customer_id = o.customer_id
LEFT JOIN order_product op ON o.order_id = op.order_id
GROUP BY c.firstname, c.lastname
ORDER BY nb_produits_commandes DESC;