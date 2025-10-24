# STAGE 1: Build the application using a full JDK/Gradle image
FROM eclipse-temurin:21-jdk-jammy AS build
WORKDIR /app
# Copy the project files
COPY gradlew .
COPY gradle .
COPY build.gradle .
COPY settings.gradle .
COPY src ./src

# Build the executable JAR
RUN ./gradlew bootJar --no-daemon

# STAGE 2: Create the final, lean runtime image (JRE only)
# Use JRE for smaller image size and better security
FROM eclipse-temurin:21-jre-jammy

# Set a low-privilege user
RUN useradd -u 1000 -ms /bin/bash spring
USER spring

WORKDIR /app

# Copy only the built JAR file from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the default Spring Boot port (Render will override this, but it's good practice)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]