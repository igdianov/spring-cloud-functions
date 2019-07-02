FROM maven:3.6.1-jdk-8 AS build

WORKDIR /usr/app

COPY pom.xml ./
COPY src/ ./src/
RUN mvn package


FROM openjdk:8-jdk-alpine

WORKDIR /usr/app

ENV PORT 8080

COPY --from=build /usr/app/target/reverse-*.jar ./reverse.jar

CMD ["java", "-jar", "/usr/app/reverse.jar"]
