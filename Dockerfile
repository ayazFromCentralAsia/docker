FROM maven:3.9.9-sapmachine-21 AS build
WORKDIR /app
COPY src /app/src
COPY pom.xml /app
RUN mvn dependency:resolve
RUN mvn clean package -DskipTests

FROM openjdk:21-jdk
COPY --from=build /app/target/docker-not-for-game-0.0.1-SNAPSHOT.jar /app/docker-not-for-game.jar
ENTRYPOINT ["java", "-jar", "/app/docker-not-for-game.jar"]