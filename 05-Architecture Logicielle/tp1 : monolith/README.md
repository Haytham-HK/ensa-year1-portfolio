# TP 1: Simple Monolithic E-commerce Application

This project is a simple monolithic application for managing products in an e-commerce setting. It's built with Spring Boot and provides a REST API for CRUD operations on products. This was a practical work for my first year, where I learned about monolithic architectures, Spring Boot, and building REST APIs.

## Project workflow 

1-  ​**Project Setup**: Bootstrapped the application using Spring Initializr to quickly pull in the standard dependencies for Web, JPA, and Lombok.

2- **​Data Model**: Defined a simple Product entity to map out basic properties like name, price, and stock levels.

3- **​Persistence**: Used the ProductRepository interface to handle database interactions and explored @RepositoryRestResource to auto-generate endpoints.

4- ​**Business Logic**: Set up a basic ProductService to organize the logic for handling product updates and retrieval.

5- **​API Layer**: Wired up the ProductController to expose the necessary REST endpoints for external consumption.

6- **​Testing**: Ran through the CRUD operations in Postman to verify that the endpoints were responding as expected.


## Evidence

Here are some screenshots of my work:

![Screenshot 1](evidence/screenshot-1.png)
![Screenshot 2](evidence/screenshot-2.png)
![Screenshot 3](evidence/screenshot-3.png)
![Screenshot 4](evidence/screenshot-4.png)
![Screenshot 5](evidence/screenshot-5.png)
![Screenshot 6](evidence/screenshot-6.png)
