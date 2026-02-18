# Stage 1 - Build React
FROM node:18-alpine AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
RUN npm run build

# Stage 2 - Build Spring Boot
FROM maven:3.9.6-eclipse-temurin-17 AS backend-build
WORKDIR /app
COPY backend/pom.xml .
RUN mvn dependency:go-offline
COPY backend/src ./src
RUN mvn clean package -DskipTests

# Stage 3 - Final Image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

COPY --from=backend-build /app/target/*.jar app.jar
COPY --from=frontend-build /app/frontend/build ./static

EXPOSE 5000

ENTRYPOINT ["java","-jar","app.jar","--server.port=5000"]
