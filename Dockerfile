# Use official Tomcat 11 as the base image
FROM tomcat:11-jdk17-temurin

# Set environment variables for RDS database connection
ENV DB_HOST=database-1.c7gyiewiil8u.eu-north-1.rds.amazonaws.com
ENV DB_PORT=3306
ENV DB_NAME=jwt
ENV DB_USER=admin
ENV DB_PASSWORD=ADMIN9119019812

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Copy the WAR file to Tomcat's webapps directory
COPY target/LoginWebApp.war /usr/local/tomcat/webapps/LoginWebApp.war

# Set working directory
WORKDIR /usr/local/tomcat

# Expose port 8080 for the Tomcat server
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
