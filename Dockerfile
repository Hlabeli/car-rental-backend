FROM openjdk:19 as buildstage
WORKDIR /app
LABEL authors="hlabeli"

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src
RUN ./mvnw package
COPY target/*.jar app.jar

FROM openjdk:19
COPY --from=buildstage /app/app.jar .
ENTRYPOINT ["java", "-jar", "/app.jar"]