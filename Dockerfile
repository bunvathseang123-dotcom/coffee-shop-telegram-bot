# --- Stage 1: Build the JAR file ---
# CHANGED to use Java 21 build image
FROM gradle:8.6-jdk21 AS build
WORKDIR /app
# ... rest of your Dockerfile instructions ...
# Copy the Gradle wrapper files and source code
COPY gradlew .
RUN chmod +x gradlew 
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
# Build the project and create the executable JAR
RUN ./gradlew bootJar --no-daemon

 # --- Stage 2: Create the final runtime image ---
 # Use a lightweight JRE (Java Runtime Environment) for production
 # CHANGED to Java 21 
FROM eclipse-temurin:21-jre-alpine  
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
# Expose the default Spring Boot port
EXPOSE 8081
# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]