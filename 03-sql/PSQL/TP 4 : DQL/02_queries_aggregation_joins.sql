-- --- TP.04: 02 - Aggregation, Sorting, and Joins ---

SELECT nom, prenom
FROM etudiants
ORDER BY nom ASC;

SELECT nom, prenom, age
FROM etudiants
ORDER BY age DESC;

SELECT ville, COUNT(*) AS total_etudiants
FROM etudiants
GROUP BY ville;

SELECT ville, COUNT(*) AS total_etudiants
FROM etudiants
GROUP BY ville
HAVING COUNT(*) > 1;

SELECT e.nom, e.prenom, f.nom_filiere
FROM etudiants e
JOIN filieres f ON e.id_filiere = f.id;

SELECT e.nom, e.prenom, f.nom_filiere
FROM etudiants e
LEFT JOIN filieres f ON e.id_filiere = f.id;

SELECT f.departement, f.nom_filiere, COUNT(e.id) AS nb_etudiants
FROM filieres f
LEFT JOIN etudiants e ON e.id_filiere = f.id
GROUP BY f.departement, f.nom_filiere
HAVING COUNT(e.id) > 1;
