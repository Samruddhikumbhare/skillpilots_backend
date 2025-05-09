# Use appropriate base image
FROM eclipse-temurin:17-jdk-jammy as builder

WORKDIR /app
COPY . .
RUN ./mvnw clean package

# Final image
FROM eclipse-temurin:17-jre-jammy

ARG PACKAGING_TYPE=jar
ENV PACKAGING_TYPE=${PACKAGING_TYPE}

WORKDIR /app

# Copy the built artifact based on packaging type
COPY --from=builder /app/target/*.${PACKAGING_TYPE} app.${PACKAGING_TYPE}

# Expose the default port (will be mapped to 8081)
EXPOSE 8080

# Command to run based on packaging type
CMD if [ "$PACKAGING_TYPE" = "war" ]; then \
        java -jar /app/app.war; \
    else \
        java -jar /app/app.jar; \
    fi

