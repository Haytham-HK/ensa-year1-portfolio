-- --- TP.04: 00 - Schema and Data ---

CREATE TABLE filieres (
    id SERIAL PRIMARY KEY,
    nom_filiere VARCHAR(100) NOT NULL,
    departement VARCHAR(100) NOT NULL
);

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    ville VARCHAR(100),
    age INT,
    id_filiere INT,
    FOREIGN KEY (id_filiere) REFERENCES filieres (id)
);

INSERT INTO filieres (nom_filiere, departement) VALUES
('Génie Informatique', 'Informatique'),
('Réseaux et Télécoms', 'Informatique'),
('Génie Civil', 'Travaux publics');

INSERT INTO etudiants (nom, prenom, ville, age, id_filiere)
VALUES
('Alami', 'Badr', 'Beni Mellal', 24, 1),
('Errakha', 'Kaoutar', 'Casablanca', 23, 2),
('Benali', 'Youssef', 'Marrakech', 22, 1),
('Laarabi', 'Souad', 'Rabat', 25, 3),
('Ait Omar', 'Salma', 'Casablanca', NULL, 2),
('Toumi', 'Amine', 'Agadir', 21, 1),
('Fassi', 'Hiba', 'Fès', 23, 3),
('Rami', 'Oussama', 'Meknès', 26, 2),
('Bennani', 'Nada', 'Tanger', 24, 1),
('El Idrissi', 'Anas', 'Rabat', 22, NULL);
