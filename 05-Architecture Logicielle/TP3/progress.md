# Projet TP3 - Architecture Monolithe Distribuée

## État d'avancement

###  Terminé (Done)
- **Structure du projet** : Création de l'arborescence des dossiers (`app/`, `nginx/`, `services/`, `routes/`).
- **Configuration Docker** : Initialisation du fichier `docker-compose.yml` avec MongoDB, Redis, RabbitMQ et les instances applicatives.
- **Services Node.js** :
  - Connexion MongoDB (`services/mongodb.js`) avec Schéma Commande.
  - Connexion Redis (`services/redis.js`).
  - Connexion RabbitMQ (`services/rabbitmq.js`) avec logique de reconnexion automatique.
- **Routes API** :
  - `POST /commandes` : Validation, stockage MongoDB, invalidation cache Redis, publication RabbitMQ.
  - `GET /commandes` : Lecture avec cache Redis (TTL 30s) et Round-robin Nginx.
- **Consommateur RabbitMQ** : Création de `app/consumer.js` fonctionnel.
- **Dockerisation** : Création des `Dockerfile` pour l'application et Nginx (pour gérer les espaces dans les chemins).
- **Tests de bout en bout** :
  -  Load Balancer (Round-robin entre Instance-1 et Instance-2).
  -  Persistance MongoDB.
  -  Cache Redis fonctionnel (Source: MongoDB au 1er appel, puis Cache Redis).
  -  Réception des messages par le consommateur RabbitMQ.

###  À faire (To Do)
