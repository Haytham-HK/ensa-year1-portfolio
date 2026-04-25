# Use an official JDK runtime as a parent image
FROM eclipse-temurin:17-jdk-alpine

# Install curl and git
RUN apk add --no-cache curl git

# Set the working directory
WORKDIR /app

# Copy the built jar file from the target directory
COPY target/*.jar app.jar

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]