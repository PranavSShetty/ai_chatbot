# Build Stage (Using Amazon Corretto 21 - Very Stable)
FROM maven:3.9.9-amazoncorretto-21 AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# Run Stage
FROM openjdk:25-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]