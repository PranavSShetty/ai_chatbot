# 1. Build Stage
FROM maven:3.9.6-eclipse-temurin-21 AS build
# Note: We use JDK 21/23 here because JDK 25 images might be rare. 
# If your code strictly requires 25 features, use: FROM openjdk:25-jdk-slim
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# 2. Run Stage
FROM openjdk:23-jdk-slim
# (Or use openjdk:25-jdk-slim if available in Docker Hub)
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]