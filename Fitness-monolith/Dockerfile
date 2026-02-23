# Use official OpenJDK 17 image
FROM eclipse-temurin:17-jdk-jammy

# Set working directory inside container
WORKDIR /app

# Copy the fat jar built by Maven
COPY target/*.jar app.jar

# Expose applicD:ation port
EXPOSE 8081

# Environment variables (optional defaults)
ENV DB_URL=jdbc:mysql://mysql-db:3306/springboot_db
ENV DB_USER=root
ENV DB_PWD=Admin

# Run the Spring Boot app
ENTRYPOINT ["java","-jar","app.jar"]