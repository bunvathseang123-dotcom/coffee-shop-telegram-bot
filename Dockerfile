# --- Stage 1: Build the JAR file ---
FROM gradle:7.6.0-jdk17 AS build
WORKDIR /app
# Copy the Gradle wrapper files and source code
COPY gradlew .
# --- FIX: Add execute permission ---
RUN chmod +x gradlew
# --- End FIX ---
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
# Build the project and create the executable JAR
RUN ./gradlew bootJar --no-daemon

# --- Stage 2: Create the final runtime image ---
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]