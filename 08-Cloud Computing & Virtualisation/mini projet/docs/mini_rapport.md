# Rapport Mini-Projet : IA pour l'Optimisation de la Cryptographie Basée sur les Réseaux

**Module :** Cryptographie  
**Filière :** CI IACS  
**Binôme :** Kennouz Haytham & Elazzouzi Abdelhak  
**Date :** Mars 2026

---

## 1. Introduction
La cryptographie basée sur les réseaux (Lattice-based cryptography) est l'un des piliers de la cryptographie post-quantique. Sa sécurité repose sur la difficulté de problèmes tels que le **Shortest Vector Problem (SVP)** et le **Closest Vector Problem (CVP)**. La réduction de réseau (Lattice Reduction) via les algorithmes LLL et BKZ est l'outil principal pour attaquer ces schémas. Ce projet explore l'utilisation de l'Intelligence Artificielle pour optimiser ces processus de réduction.

## 2. Objectifs du Projet
- Concevoir un système intelligent capable de prédire la performance des algorithmes de réduction.
- Optimiser le choix des paramètres ($\delta$ pour LLL, $\beta$ pour BKZ) afin d'équilibrer temps d'exécution et qualité de la base.
- Développer une application Python (ALOT) démontrant cette synergie IA/Cryptographie.

## 3. Méthodologie
### 3.1. Collecte de Données
Nous avons généré un dataset synthétique en utilisant la bibliothèque `fpylll`. Plus de 150 réductions ont été effectuées sur des réseaux de dimensions 30 à 60, en variant les paramètres et en mesurant :
- Le temps d'exécution (Runtime).
- La norme du vecteur le plus court trouvé (Qualité).

### 3.2. Modèle d'IA
Nous avons entraîné deux modèles de **Random Forest Regressor** :
1. **Prédicteur de Temps :** Prédit la durée de la réduction.
2. **Prédicteur de Qualité :** Prédit la norme finale du vecteur.

Résultats de performance :
- Temps : $R^2 \approx 0.77$
- Qualité : $R^2 \approx 0.99$

## 4. Implémentation : Outil ALOT
L'application **AI-driven Lattice Optimization Tool (ALOT)** permet à l'utilisateur de :
1. Saisir les paramètres du réseau cible.
2. Recevoir une recommandation de stratégie optimisée par l'IA.
3. Exécuter la réduction et vérifier les prédictions en temps réel.

## 5. Conclusion
L'IA permet d'éviter les essais-erreurs coûteux dans le choix des paramètres de cryptanalyse. En prédisant précisément les résultats, nous pouvons maximiser l'efficacité des attaques ou, inversement, mieux paramétrer nos cryptosystèmes pour résister à ces optimisations.

---
**Encadrant :** Prof. OUNACHAD
