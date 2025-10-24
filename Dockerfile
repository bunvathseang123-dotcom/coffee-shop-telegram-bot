# ----------------------------------------------------------------------
# Stage 1: Build the WAR
# ----------------------------------------------------------------------
# Use 'gradle' user if available in this image for proper permissions
FROM gradle:8.7-jdk21-alpine AS builder 

# Set the working directory
WORKDIR /app

# Copy the wrapper files, build files, and apply permissions
COPY gradlew .
COPY gradle/ gradle/
RUN chmod +x gradlew  <-- FIX 1: Make the wrapper executable

# Copy the rest of the source code (assuming 'gradle' is the user)
# If the user is 'gradle', add '--chown' to ensure proper ownership.
# You may need to check the exact user name for this base image.
COPY --chown=gradle:gradle . .

# Run the build command
RUN ./gradlew clean build -x test  <-- Use ./gradlew instead of just gradlew

# ----------------------------------------------------------------------
# Stage 2: Run the WAR
# ----------------------------------------------------------------------
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
EXPOSE 8080

# Note: Your COPY path in the final stage needs a slight correction
# It should typically point to 'build/libs' from the build stage.
# The `*.war` syntax is correct.
COPY --from=builder /app/build/libs/*.war app.war 

# Run the Spring Boot application
# Note: You can simplify the CMD if you don't need the PORT variable
CMD ["java", "-Dserver.port=8080", "-jar", "app.war"]