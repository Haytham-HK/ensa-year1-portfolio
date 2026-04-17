# TP 5 : NoSQL avec MongoDB - Gestion des Alertes de Sécurité

Ce projet documente la réalisation du TP 5 portant sur l'utilisation de **MongoDB** comme base de données NoSQL pour la gestion d'un système d'alertes de sécurité.

## Technologies Utilisées

- **Base de données :** MongoDB (NoSQL orienté document)
- **Interface :** MongoDB Shell (mongosh)
- **Concepts :** CRUD, Opérateurs de filtrage, Indexation, Framework d'agrégation, Validation de schéma.

## Travail Réalisé

### 1. Configuration et État initial
Nous avons commencé par vérifier que le service MongoDB était opérationnel sur le système.

![État MongoDB](screens/01_MongoDB_Status_Active.png)

### 2. Insertion de Données
Nous avons exploré les méthodes d'insertion de documents (`insertOne` et `insertMany`) pour peupler notre collection d'alertes.

- **Insertion unique :**
![InsertOne](screens/02_InsertOne_Alerte_Intrusion.png)

- **Insertion multiple :**
![InsertMany](screens/03_InsertMany_Alertes.png)

### 3. Consultation et Filtrage
Utilisation de `find()` avec des projections et des opérateurs pour extraire des informations spécifiques.

- **Nombre total de documents :**
![Count](screens/04_Count_Documents_Total.png)

- **Recherche avec projection (Filtre : Benali) :**
![Projection](screens/05_Find_Benali_Projection.png)

- **Utilisation des opérateurs `$gte` et `$lte` (Scores entre 7 et 9) :**
![Opérateurs](screens/06_Find_Score_7_9_Operators.png)

- **Extraction des tags distincts :**
![Distinct](screens/07_Distinct_Tags_List.png)

### 4. Indexation et Performance
Optimisation des recherches via la création d'index.

- **Création d'un index de texte :**
![Index Texte](screens/08_Create_Text_Index.png)

- **Indexation sur l'IP source :**
![Index IP](screens/15_Index_Source_IP.png)

### 5. Agrégation Avancée
Analyse des données à l'aide du framework d'agrégation (`$group`, `$unwind`, `$lookup`).

- **Groupement par Analyste :**
![Group By Analyste](screens/09_Aggregate_Group_By_Analyste.png)

- **Désassemblage des tags (`$unwind`) et groupement :**
![Unwind Tags](screens/10_Aggregate_Unwind_Group_Tags.png)

- **Jointure entre collections via `$lookup` :**
![Lookup Join](screens/14_Aggregate_Lookup_Join.png)

### 6. Mise à jour et Validation
Gestion de l'intégrité des données et mises à jour groupées.

- **Mise à jour en masse du statut :**
![UpdateMany](screens/11_UpdateMany_Status_En_Cours.png)

- **Test de validation de schéma (Erreur de mode strict) :**
![Validation Error](screens/12_Validation_Schema_Strict_Error.png)

- **Validation avec action "warn" (Succès avec avertissement) :**
![Validation Warn](screens/13_Validation_Action_Warn_Success.png)

### 7. Nettoyage
Suppression des documents obsolètes.

- **Suppression des alertes résolues :**
![DeleteMany](screens/16_DeleteMany_Alertes_Resolu.png)

---
*Réalisé dans le cadre du module Big Data - ENSA.*
