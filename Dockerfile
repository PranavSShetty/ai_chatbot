# 1. Build Stage (Amazon Corretto is very stable)
FROM maven:3.9.9-amazoncorretto-21 AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# 2. Run Stage (Use Eclipse Temurin - Guaranteed to exist)
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]