FROM maven:3.8.5-jdk-8 AS builder

ADD ./pom.xml pom.xml
ADD ./src src/

RUN mvn clean package

From openjdk:8-jre

COPY --from=builder target/*.jar app.jar

EXPOSE 80

CMD ["java", "-jar", "app.jar"]