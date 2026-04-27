# Incident Management System

**Supervised by:** [Pr. ELBAGHAZAOUI](https://github.com/bahaa-eddine)

## Overview
This is a microservices-based Incident Management System. It provides a full-stack solution with distinct microservices for handling users, incidents, comments, notifications, and real-time chat, along with an AI-driven service for assigning priority. It includes two frontend applications (Client and Admin).

## Architecture & Services
The backend relies on Spring Boot, Spring Cloud, and FastAPI for the microservices architecture, secured by Keycloak and using an API Gateway for routing.

```mermaid
graph TD
    Client[React Client App] --> Gateway[API Gateway]
    Admin[React Admin Dashboard] --> Gateway[API Gateway]
    
    Gateway --> Eureka[Eureka Server]
    Gateway --> Config[Config Server]
    
    Gateway --> Incident[Incident Service]
    Gateway --> User[User Service]
    Gateway --> Comment[Comment Service]
    Gateway --> Chat[Chat Service]
    Gateway --> Notification[Notification Service]
    
    Incident --> DB[(PostgreSQL)]
    User --> DB
    Comment --> DB
    Chat --> DB
    Notification --> DB
    
    Incident --> MinIO[(MinIO Object Storage)]
    Incident --> AI[AI Priority Service]
    
    Chat --> Incident
    
    subgraph Sécurité
        Keycloak[Keycloak IAM]
    end
    
    Gateway -.-> Keycloak
    Incident -.-> Keycloak
```

### Core Microservices (Java / Spring Boot)
- **user-service:** Manages user accounts.
- **incident-service:** Handles the creation and tracking of incidents.
- **comment-service:** Manages discussions related to incidents.
- **notification-service:** Handles user notifications.
- **chat-service:** Real-time chat functionality.

### AI Service (Python / FastAPI)
- **ai-priority-service:** Uses AI algorithms to automatically assess and assign incident priority levels.

### Infrastructure & Discovery (Spring Cloud)
- **gateway-service:** The primary entry point for external traffic, routing to internal microservices.
- **eureka-server:** Service registry for dynamic discovery.
- **config-service:** Centralized configuration service pulling from `config-repo`.

### Frontend (React)
- **admin-dashboard:** Dashboard for administrators.
- **client-app:** User-facing application for reporting incidents.

## Technologies Used

**Backend:**
- Java, Spring Boot, Spring Cloud
- Python, FastAPI, Uvicorn, Pydantic

**Databases & Storage:**
- PostgreSQL (Primary Relational Database)
- MinIO (S3-compatible Object Storage)

**Security & Identity:**
- Keycloak (OAuth2 / OIDC)

**Frontend:**
- React.js, Node.js

**DevOps & Deployment:**
- Docker, Docker Compose

## Visual Evidence

### Client Application
| Client Home | Client Dashboard |
|:---:|:---:|
| ![Client Home](evidence/01_client_home.png) | ![Client Dashboard](evidence/02_client_dashboard.png) |

| Report Incident | Incident Submission |
|:---:|:---:|
| ![Report Incident](evidence/03_report_incident.png) | ![Incident Submission](evidence/04_incident_submission.png) |

| Incident List | Chat Feature |
|:---:|:---:|
| ![Incident List](evidence/05_incident_list.png) | ![Chat Feature](evidence/10_chat_feature.png) |

### Admin Dashboard
| Admin Login | Admin Dashboard |
|:---:|:---:|
| ![Admin Login](evidence/06_admin_login.png) | ![Admin Dashboard](evidence/07_admin_dashboard.png) |

| Admin Incidents | Admin Incident Edit |
|:---:|:---:|
| ![Admin Incidents](evidence/08_admin_incidents.png) | ![Admin Incident Edit](evidence/09_admin_incident_edit.png) |

| User Management | System Status |
|:---:|:---:|
| ![User Management](evidence/13_user_management.png) | ![System Status](evidence/14_system_status.png) |

### Advanced Features
| Real-time Notifications | AI Priority Assignment |
|:---:|:---:|
| ![Real-time Notifications](evidence/11_notification_realtime.png) | ![AI Priority](evidence/12_ai_priority.png) |

## Development

The central configuration files for all microservices are located in the `config-repo` directory. The main backend and frontend code resides under the `gestion-incidents` directory.

For more details, see [DOCUMENTATION.md](DOCUMENTATION.md).
