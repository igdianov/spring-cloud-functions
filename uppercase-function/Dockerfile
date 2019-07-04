FROM maven:3.6.1-jdk-8

WORKDIR /usr/app

COPY pom.xml ./
COPY src/ ./src/
RUN mvn package

ENV PORT 8080

CMD ["java", "-jar", "/usr/app/target/uppercase-0.0.1-SNAPSHOT.jar"]
