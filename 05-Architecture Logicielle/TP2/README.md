# Monolith Modular 

-   **Product Module Refinement**: Updated API interactions using DTOs and MapStruct, leading to better separation of concerns within services.
-   **Customer Module Establishment**: A dedicated Customer module was established, including entities, repositories, DTOs, mappers, services for logic (e.g., customer existence verification), and RESTful API endpoints for CRUD operations.
-   **Order Module Development**: A new Order module was built to manage customer orders, integrating with Product and Customer services. This involved new entities (`Order`, `OrderItem`), an `OrderStatus` enum, repositories, DTOs, mappers, and services to handle order creation and retrieval of customer order history.
-   **Technical Enhancements**:
    -   MapStruct mapping issues, specifically with generated `id` fields, were addressed by explicitly ignoring them.
    -   Lombok and MapStruct compatibility was ensured by configuring `lombok-mapstruct-binding` in Maven.
    -   Application startup clarity was improved by explicitly defining the `mainClass` in `pom.xml` for the `spring-boot-maven-plugin`.

## How to run

For those looking to run or explore this application:

1.  **Prerequisites**:
    -   Ensure Java 17 or a newer version is installed.
    -   Maven 3.x is required for building the project.
    -   A PostgreSQL database instance is needed, with connection details configured in `src/main/resources/application.properties`.

2.  **Building the Application**:
    Navigate to the `monolith` directory in your terminal and execute the following command:
    ```bash
    mvn clean install
    ```

3.  **Launching the Application**:
    Once built, the application can be started using:
    ```bash
    java -jar target/monolith-0.0.1-SNAPSHOT.jar
    ```
    The application should then be accessible via `http://localhost:8080`.

## Requirement


-   **Java 17**
-   **Spring Boot 3.2.2**
-   **Maven 3.x**
-   **PostgreSQL** (for persistence)
-   **Spring Data JPA** (for data access)
-   **MapStruct** (to simplify data mapping)
-   **Lombok** (to reduce boilerplate code)

**Student:** Haytham KENNOUZ