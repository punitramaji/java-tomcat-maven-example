FROM maven:3.5-jdk-8 as BUILD
COPY . /
RUN mvn -f pom.xml clean package

FROM openjdk:8-jre-alpine3.7
COPY --from=BUILD target/dependency/webapp-runner.jar /target/dependency/webapp-runner.jar
COPY --from=BUILD target/*.war /target/*.war
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "target/dependency/webapp-runner.jar", "target/*.war" ]
