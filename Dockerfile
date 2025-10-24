# Stage 1: Build the application using a dedicated builder image with Java 17 and Gradle
FROM gradle:jdk17-alpine AS builder
# Copy the entire project into the Docker build environment
COPY . /app
# Set the working directory
WORKDIR /app
# Grant execution permissions to the Gradle wrapper script and build the project
RUN chmod +x gradlew
RUN ./gradlew build -x test

# Stage 2: Create the final, lightweight runtime image
# Use a minimal Java Runtime Environment (JRE) for the final app
FROM openjdk:17-jre-slim
# Expose the default port Render uses for web services
EXPOSE 10000
# Copy the built JAR file from the builder stage into the final image
# The JAR file is typically located in build/libs/
COPY --from=builder /app/build/libs/*.jar /app/app.jar
# Define the command to run the Java application
CMD ["java", "-jar", "/app/app.jar"]