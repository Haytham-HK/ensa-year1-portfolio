CREATE TABLE produits (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prix NUMERIC(10,2) NOT NULL
);

CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150)
);

INSERT INTO produits (nom, prix) VALUES
  ('Mechanical Keyboard', 799.90),
  ('Wireless Mouse', 199.99);

INSERT INTO clients (nom, email) VALUES
  ('Amal Zahra', 'amal@example.com'),
  ('Yassine Ali', 'yassine@example.com');
