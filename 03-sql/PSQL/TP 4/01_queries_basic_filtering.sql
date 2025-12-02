-- --- TP.04: 01 - Basic Filtering (WHERE, AND/OR, LIKE, IN, BETWEEN, IS NULL) ---

SELECT * FROM etudiants;

SELECT nom, prenom, ville
FROM etudiants
WHERE ville = 'Casablanca';

SELECT nom, prenom, ville
FROM etudiants
WHERE ville = 'Casablanca' OR ville = 'Rabat';

SELECT nom, prenom, age
FROM etudiants
WHERE ville = 'Casablanca' AND age > 22;

SELECT nom, prenom, ville
FROM etudiants
WHERE NOT ville = 'Marrakech';

SELECT nom, prenom
FROM etudiants
WHERE nom LIKE 'E%';

SELECT nom, prenom
FROM etudiants
WHERE prenom LIKE '%a';

SELECT nom, prenom, ville
FROM etudiants
WHERE ville IN ('Casablanca', 'Rabat', 'Marrakech');

SELECT nom, prenom, age
FROM etudiants
WHERE age BETWEEN 22 AND 24;

SELECT nom, prenom
FROM etudiants
WHERE age IS NULL;

SELECT nom, prenom, age
FROM etudiants
WHERE age IS NOT NULL;
