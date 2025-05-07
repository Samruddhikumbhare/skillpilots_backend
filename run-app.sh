#!/bin/sh

echo "Starting Spring Boot application..."

# If WAR exists, prefer that
if [ -f *.war ]; then
  echo "WAR file found. Running it..."
  java -jar *.war
elif [ -f *.jar ]; then
  echo "JAR file found. Running it..."
  java -jar *.jar
else
  echo "❌ No executable JAR or WAR file found in /app"
  exit 1
fi
