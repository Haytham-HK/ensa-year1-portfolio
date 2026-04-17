# TP 5 : NoSQL avec MongoDB - Gestion des Alertes de Sécurité

Ce projet documente la réalisation du TP 5 portant sur l'utilisation de **MongoDB** comme base de données NoSQL pour la gestion d'un système d'alertes de sécurité.

## Technologies Utilisées

- **Base de données :** MongoDB (NoSQL orienté document)
- **Interface :** MongoDB Shell (mongosh)
- **Concepts :** CRUD, Opérateurs de filtrage, Indexation, Framework d'agrégation, Validation de schéma (JSON Schema).

## Travail Réalisé

### 1. Configuration et État du Service
Vérification du statut du service MongoDB pour s'assurer qu'il est opérationnel.

![Statut Mongod](screens/01_Status_Service_Mongod.png)

### 2. Insertion de Données
Exploration des méthodes d'insertion pour peupler la collection `alertes`.

- **Insertion d'une alerte critique :**
![InsertOne Alerte](screens/02_InsertOne_Alerte_Critique.png)

- **Résultat d'une insertion multiple (insertMany) :**
![InsertMany Résultat](screens/03_InsertMany_Alertes_Resultat.png)

### 3. Requêtes de Recherche et Filtrage
Utilisation de `find()` avec des projections et des opérateurs logiques.

- **Comptage du nombre total d'alertes :**
![Count Documents](screens/04_CountDocuments_Total_6.png)

- **Recherche par analyste avec projection des champs :**
![Recherche Analyste](screens/05_Recherche_Analyste_Projection.png)

- **Filtrage par score de menace (entre 7 et 9) :**
![Filtre Score](screens/06_Filtre_Score_Menace_7_9.png)

- **Extraction de la liste des tags distincts :**
![Tags Distincts](screens/07_Liste_Tags_Distincts.png)

### 4. Indexation
Optimisation des performances de recherche.

- **Création d'un index textuel sur la description :**
![Index Textuel](screens/08_Creation_Index_Textuel.png)

### 5. Analyse de Données (Agrégation)
Utilisation du framework d'agrégation pour extraire des statistiques.

- **Nombre d'alertes par analyste :**
![Agrégat Analyste](screens/09_Agregat_Nombre_Alertes_Analyste.png)

- **Nombre d'alertes par tag (utilisation de `$unwind`) :**
![Agrégat Tag](screens/10_Agregat_Nombre_Alertes_Tag.png)

- **Jointure avec la collection `signatures` (utilisation de `$lookup`) :**
![Agrégat Lookup](screens/16_Agregat_Lookup_Jointure_Signatures.png)

### 6. Mises à Jour et Validation de Schéma
Gestion du cycle de vie des alertes et contrôle de l'intégrité des données.

- **Mise à jour en masse du statut des intrusions :**
![Mise à jour Statut](screens/11_Mise_A_Jour_Statut_En_Cours.png)

- **Échec de validation : Sévérité invalide (hors enum) :**
![Échec Sévérité](screens/12_Validation_Echec_Severity_Invalide.png)

- **Échec de validation : Champs obligatoires manquants :**
![Échec Champs](screens/13_Validation_Echec_Champs_Manquants.png)

- **Échec de validation : Score hors limites :**
![Échec Score](screens/14_Validation_Echec_Score_Hors_Limites.png)

- **Création d'une collection avec avertissement (`validationAction: "warn"`) :**
![Validation Warn](screens/15_Creation_Collection_Validation_Warn.png)

---
*Réalisé dans le cadre du module Big Data.*
