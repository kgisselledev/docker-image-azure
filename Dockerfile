FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/mi-app-docker-azure-1.0.0.jar mi-app-docker-azure.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "mi-app-docker-azure.jar"]
