# Gestion d'Incidents Microservices

Une application moderne et scalable pour la gestion des incidents, construite avec une architecture microservices (Spring Boot, Python, React).

## 📸 Aperçu de l'Application

### 👤 Interface Client
| Accueil Client | Dashboard Personnel |
| :---: | :---: |
| ![Accueil](./evidence/01_client_home.png) | ![Dashboard](./evidence/02_client_dashboard.png) |

| Signalement d'un Incident | Suivi des Tickets |
| :---: | :---: |
| ![Signalement](./evidence/03_report_incident.png) | ![Liste Incidents](./evidence/05_incident_list.png) |

### 🛠️ Interface Administration
| Dashboard Admin | Gestion des Incidents |
| :---: | :---: |
| ![Dashboard Admin](./evidence/07_admin_dashboard.png) | ![Liste Admin](./evidence/08_admin_incidents.png) |

| Édition & Solution | Gestion des Utilisateurs |
| :---: | :---: |
| ![Edition](./09_admin_incident_edit.png) | ![Utilisateurs](./evidence/13_user_management.png) |

### 🚀 Fonctionnalités Avancées
| Chat en Temps Réel | Analyse de Priorité (IA) |
| :---: | :---: |
| ![Chat](./evidence/10_chat_feature.png) | ![IA](./evidence/12_ai_priority.png) |

## 🛠️ Architecture Technique

- **Backend:** Spring Boot, Spring Cloud (Eureka, Config, Gateway)
- **IA:** Python (FastAPI/Uvicorn) pour le tri intelligent des priorités
- **Frontend:** React.js avec Material UI
- **Sécurité:** Keycloak (OAuth2/OIDC)
- **Base de données:** PostgreSQL, MinIO (Stockage d'images)
- **Messaging:** RabbitMQ (Notifications)
- **Déploiement:** Docker, Docker Compose

## 🚦 Démarrage Rapide

1. Assurez-vous que Docker est installé.
2. Lancez le script de démarrage :
   ```bash
   ./start.sh
   ```
3. Accédez aux services :
   - Client App: `http://localhost:3000`
   - Admin App: `http://localhost:3003`
   - Eureka: `http://localhost:8761`
   - Keycloak: `http://localhost:8180`
