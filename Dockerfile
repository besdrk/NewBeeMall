FROM maven:3.8.5-jdk-8 AS builder

ADD ./pom.xml pom.xml
ADD ./src src/

RUN mvn clean package

From openjdk:8-jre

COPY --from=builder target/*.jar app.jar
COPY --from=builder src/main/resources/upload.zip upload.zip

RUN mkdir /opt/image/upload/
RUN unzip -d /opt/image/upload/ upload.zip

EXPOSE 80

CMD ["java", "-jar", "app.jar"]