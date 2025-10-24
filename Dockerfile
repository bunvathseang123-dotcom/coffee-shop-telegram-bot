# --- Stage 1: Build the JAR file ---
FROM gradle:7.6.0-jdk17 AS build
WORKDIR /app
# Copy the Gradle wrapper files and source code
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
# Build the project and create the executable JAR
RUN ./gradlew bootJar --no-daemon

# --- Stage 2: Create the final runtime image ---
# Use a lightweight JRE (Java Runtime Environment) for production
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copy the JAR from the build stage
COPY --from=build /app/build/libs/*.jar app.jar
# Expose the default Spring Boot port
EXPOSE 8080
# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]