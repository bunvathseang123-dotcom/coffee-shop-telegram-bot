# ---------- Stage 1: Build the WAR ----------
FROM gradle:8.7-jdk21-alpine AS builder
WORKDIR /app
COPY . .
RUN gradle clean build -x test

# ---------- Stage 2: Run the WAR ----------
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/*.war app.war

# Expose default port
EXPOSE 8080

# Run the Spring Boot app
CMD ["sh", "-c", "java -Dserver.port=${PORT:-8080} -jar app.war"]
