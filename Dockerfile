# Stage 1: Builder - creates both JAR and WAR
FROM maven:3.8.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: JAR runtime (will use port 8081)
FROM eclipse-temurin:17-jdk-jammy as jar-app
ARG JAR_FILE=/app/target/*.jar
COPY --from=builder ${JAR_FILE} app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app.jar", "--server.port=8081"]

# Stage 3: WAR runtime (Tomcat 10.1.40 on port 8001)
FROM tomcat:10.1.40-jdk17-temurin-jammy as war-app
ARG WAR_FILE=/app/target/*.war
COPY --from=builder ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war
# Update server.xml to change Tomcat's default port
RUN sed -i 's/port="8080"/port="8001"/' /usr/local/tomcat/conf/server.xml
EXPOSE 8001
CMD ["catalina.sh", "run"]

