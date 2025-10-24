# ----------------------------------------------------
# STAGE 1: Build the application
# ----------------------------------------------------
FROM eclipse-temurin:21-jdk-jammy AS build
WORKDIR /app

# 1. Copy Gradle wrapper and configuration files (Infrequently Changed)
COPY gradlew .
COPY gradle/ .gradle/
COPY build.gradle .
COPY settings.gradle .

# 2. Grant execute permission (The fix for your previous error)
RUN chmod +x ./gradlew

# 3. Download/Cache Dependencies (Only runs if build.gradle changes)
# This step forces Gradle to download dependencies based on the build file.
# We give it a dummy command to force dependency resolution.
RUN ./gradlew dependencies --no-daemon

# 4. Copy source code (Frequently Changed)
COPY src /app/src 

# 5. Build the executable JAR (Only runs if src or the above layers change)
RUN ./gradlew bootJar --no-daemon