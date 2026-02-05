# 1. Build Stage
FROM maven:3-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
# Force permission fix for the wrapper
RUN chmod +x mvnw
# Build the app, skipping tests to save time
RUN ./mvnw clean package -DskipTests

# 2. Run Stage
FROM openjdk:23-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]