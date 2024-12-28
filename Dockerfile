# Stage 1: Build Stage
FROM maven:3.8.6-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project descriptor (pom.xml)
COPY pom.xml .

# Download all dependencies (to cache dependencies on rebuild)
RUN mvn dependency:go-offline

# Copy the source code
COPY src /app/src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Runtime Stage
FROM openjdk:17-jdk-alpine AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your Spring Boot application runs on (default is 8080)
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
