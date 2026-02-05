# Use a highly stable Maven version to avoid download errors
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
# Fix permissions
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# Run Stage
FROM openjdk:23-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]