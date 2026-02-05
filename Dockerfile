# 1. Build Stage
FROM maven:3.9-eclipse-temurin-23 AS build
WORKDIR /app
COPY . .
# FIX: Use 'mvn' directly (bypass the potentially buggy wrapper script)
RUN mvn clean package -DskipTests

# 2. Run Stage
FROM eclipse-temurin:23-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]