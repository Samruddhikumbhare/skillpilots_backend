#!/bin/sh

echo "Starting Spring Boot application..."

# Look for WAR and JAR files safely
WAR_FILE=$(find . -maxdepth 1 -name "*.war" | head -n 1)
JAR_FILE=$(find . -maxdepth 1 -name "*.jar" | head -n 1)

if [ -n "$WAR_FILE" ]; then
  echo "WAR file found: $WAR_FILE. Running it..."
  exec java -jar "$WAR_FILE"
elif [ -n "$JAR_FILE" ]; then
  echo "JAR file found: $JAR_FILE. Running it..."
  exec java -jar "$JAR_FILE"
else
  echo "❌ No executable JAR or WAR file found in /app"
  exit 1
fi
