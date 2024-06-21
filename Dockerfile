# Bazalı şəkili seçin
FROM openjdk:17-jdk-slim

# Kodlarınızı konteynerə köçürün
WORKDIR /app
COPY . /app

# Maven istifadə olunursa:
RUN apt-get update && apt-get install -y maven
RUN mvn clean package

# Web server kimi Tomcat istifadə edilərsə:
# Tomcat yükləyin
RUN apt-get update && apt-get install -y wget
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.0.10/bin/apache-tomcat-10.0.10.tar.gz
RUN tar xzvf apache-tomcat-10.0.10.tar.gz -C /usr/local
RUN mv /usr/local/apache-tomcat-10.0.10 /usr/local/tomcat
RUN rm apache-tomcat-10.0.10.tar.gz

# Tətbiqi Tomcat vebapps qovluğuna kopyalayın
COPY target/your-app.war /usr/local/tomcat/webapps/

# Tomcat portunu açın
EXPOSE 8080

# Tomcat-i başlatmaq üçün komanda
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
