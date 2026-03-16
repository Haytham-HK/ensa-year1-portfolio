# Présentation Mini-Projet : IA & Cryptographie
## Sujet : Optimisation de la Cryptographie Basée sur les Réseaux par l'IA

**Par :** Kennouz Haytham & Elazzouzi Abdelhak

---

## Diapositive 1 : Introduction
- Réseaux (Lattices) = Post-Quantique.
- Problème Hard : SVP (Shortest Vector Problem).
- Outils : LLL (1982) & BKZ (1991).
- **Problème :** Comment choisir les paramètres optimaux ?

## Diapositive 2 : L'Approche IA
- Objectif : Prédire l'issue d'une réduction avant de la lancer.
- Features : Dimension, Bits, Algorithme, Paramètres.
- Targets : Temps d'exécution, Norme finale (Qualité).

## Diapositive 3 : Pipeline du Projet
1. **Génération :** 150+ réseaux via `fpylll`.
2. **Entraînement :** Random Forest Regressor.
3. **Optimisation :** Recommandation de stratégie via les modèles.

## Diapositive 4 : Résultats
- Prédiction de Qualité (Norme) extrêmement précise ($R^2 = 0.99$).
- Prédiction de Temps fiable ($R^2 = 0.77$).
- Réduction significative des tâtonnements manuels.

## Diapositive 5 : Démonstration ALOT
- Interface CLI interactive.
- Analyse IA en temps réel.
- Validation sur réseaux réels.

## Diapositive 6 : Conclusion & Perspectives
- L'IA comme assistant à la cryptanalyse.
- Extension possible : Reinforcement Learning pour le choix dynamique du block size (BKZ).
- Vers une sécurité plus robuste des systèmes post-quantiques.

---
**Merci pour votre attention !**
