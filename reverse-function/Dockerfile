FROM maven:3.6.1-jdk-8

WORKDIR /usr/app

COPY pom.xml ./
COPY src/ ./src/
RUN mvn package

ENV PORT 8080

COPY /usr/app/target/reverse-*.jar ./reverse.jar

CMD ["java", "-jar", "/usr/app/reverse.jar"]
