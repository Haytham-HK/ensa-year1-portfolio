-- 1. List the first 10 films (title + year), sorted alphabetically.
SELECT title, release_year
FROM film
ORDER BY title ASC
LIMIT 10;

-- 2. Actors whose first name starts with 'A'.
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'A%';

-- 3. Films rated 'PG-13'.
SELECT title, rating
FROM film
WHERE rating = 'PG-13';

-- 4. Films longer than 2 hours (length > 120).
SELECT title, length
FROM film
WHERE length > 120;

-- 5. Customers without an email address.
SELECT customer_id, first_name, last_name
FROM customer
WHERE email IS NULL;

-- 6. Distinct cities of customers.
SELECT DISTINCT c.first_name, c.last_name, ci.city
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON ci.city_id = a.city_id;

-- 7. Top 5 films by rental_rate.
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;

-- 8. Total number of films.
SELECT COUNT(*) AS total_films
FROM film;

-- 9. Average duration (length) of films.
SELECT ROUND(AVG(length)) AS average_length
FROM film;

-- 10. Customers from 'Rabat' or 'Casablanca' (Note: DB has no such cities, using 'London'/'Berlin' as examples)
-- The query from the report (using city names that are not in the DB):
-- SELECT first_name, last_name, city
-- FROM customer
-- JOIN address ON customer.address_id = address.address_id
-- JOIN city ON city.city_id = address.city_id
-- WHERE city.city IN ('Rabat', 'Casablanca');

-- A working example with cities from the database:
SELECT c.first_name, c.last_name, ci.city
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON ci.city_id = a.city_id
WHERE ci.city IN ('London', 'Berlin');

-- 11. Rentals with film title (rental_id, rental_date, title).
SELECT r.rental_id, r.rental_date, f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;

-- 12. Actors for a specific film (e.g., 'ACADEMY DINOSAUR').
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR';

-- 13. Payments with customer name (amount, date, name).
SELECT p.amount, p.payment_date, c.first_name, c.last_name
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id;

-- 14. Films and their categories.
SELECT f.title, c.name AS category_name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;

-- 15. Rentals with the staff member who processed them.
SELECT r.rental_id, s.first_name AS staff_first_name, a.address AS staff_address
FROM rental r
JOIN staff s ON r.staff_id = s.staff_id
JOIN address a ON s.address_id = a.address_id;

-- 16. Customers and their country.
SELECT c.first_name, co.country
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 17. Films available in Store 1.
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE i.store_id = 1;

-- 18. Number of rentals per customer.
SELECT c.customer_id, c.first_name, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY rental_count DESC;

-- 19. Average film length per category.
SELECT c.name AS category_name, ROUND(AVG(f.length)) AS average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_length DESC;

-- 20. Top 10 customers by total payment amount.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_paid DESC
LIMIT 10;