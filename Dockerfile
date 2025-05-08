FROM openjdk:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the built artifacts (WAR or JAR)
COPY target/*.jar target/*.war /app/

# Add an entry script
COPY run-app.sh /app/run-app.sh
RUN chmod +x /app/run-app.sh

# Expose backend port
EXPOSE 8081

# Run the script to decide between WAR and JAR
ENTRYPOINT ["/bin/sh", "-c", "./run-app.sh"]

