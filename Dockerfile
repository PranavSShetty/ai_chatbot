# 1. Build Stage (Uses pure Java 25)
FROM openjdk:25-jdk-slim AS build
WORKDIR /app
COPY . .

# Grant execution permissions to the wrapper
RUN chmod +x mvnw

# Build using the wrapper (skipping tests for speed)
RUN ./mvnw clean package -DskipTests

# 2. Run Stage (Runtime)
FROM openjdk:25-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]