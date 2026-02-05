# 1. Build Stage (Uses official Maven + Java 23)
FROM maven:3.9-eclipse-temurin-23 AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# 2. Run Stage (Runtime with Java 23)
FROM openjdk:23-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]